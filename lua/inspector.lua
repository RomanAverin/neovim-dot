-- Highlight Inspector for Neovim 0.9+
-- Uses modern vim.inspect_pos() API
local M = {}

-- State for tracking open inspector window
local state = {
  win_id = nil,
  bufnr = nil,
}

-- Get detailed highlight group information (colors and attributes)
local function get_hl_details(hl_group)
  if not hl_group or hl_group == "" or hl_group == "none" then
    return nil
  end

  local ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = hl_group, link = false })
  if not ok or not hl_def then
    return nil
  end

  local details = {}

  -- Colors (convert from number to hex)
  if hl_def.fg then
    details.fg = string.format("#%06x", hl_def.fg)
  end
  if hl_def.bg then
    details.bg = string.format("#%06x", hl_def.bg)
  end
  if hl_def.sp then
    details.sp = string.format("#%06x", hl_def.sp)
  end

  -- Attributes
  local attrs = {}
  if hl_def.bold then
    table.insert(attrs, "bold")
  end
  if hl_def.italic then
    table.insert(attrs, "italic")
  end
  if hl_def.underline then
    table.insert(attrs, "underline")
  end
  if hl_def.undercurl then
    table.insert(attrs, "undercurl")
  end
  if hl_def.underdouble then
    table.insert(attrs, "underdouble")
  end
  if hl_def.underdotted then
    table.insert(attrs, "underdotted")
  end
  if hl_def.underdashed then
    table.insert(attrs, "underdashed")
  end
  if hl_def.strikethrough then
    table.insert(attrs, "strikethrough")
  end
  if hl_def.reverse then
    table.insert(attrs, "reverse")
  end
  if hl_def.standout then
    table.insert(attrs, "standout")
  end

  if #attrs > 0 then
    details.attrs = table.concat(attrs, ", ")
  end

  return details
end

-- Format detailed highlight info as lines
local function format_hl_details(hl_group, prefix)
  prefix = prefix or "  "
  local details = get_hl_details(hl_group)
  if not details then
    return {}
  end

  local lines = {}
  if details.fg then
    table.insert(lines, prefix .. "fg: " .. details.fg)
  end
  if details.bg then
    table.insert(lines, prefix .. "bg: " .. details.bg)
  end
  if details.sp then
    table.insert(lines, prefix .. "sp: " .. details.sp)
  end
  if details.attrs then
    table.insert(lines, prefix .. "attrs: " .. details.attrs)
  end

  return lines
end

-- Format inspection info into displayable lines
local function format_inspect_info(inspect_info)
  local lines = {}
  local highlights = {}

  local function add_line(text, hl_group)
    table.insert(lines, text)
    if hl_group then
      table.insert(highlights, { line = #lines - 1, hl_group = hl_group })
    end
  end

  -- Treesitter highlights
  if inspect_info.treesitter and #inspect_info.treesitter > 0 then
    add_line("Treesitter", "@function.call.lua")
    for _, entry in ipairs(inspect_info.treesitter) do
      local hl_group = entry.hl_group or "none"
      local hl_link = entry.hl_group_link or "none"
      local lang = entry.lang or "?"

      add_line(string.format(" • %s → %s [%s]", hl_group, hl_link, lang))

      -- Show detailed info for the final highlight group (after link resolution)
      local detail_lines = format_hl_details(hl_link)
      for _, line in ipairs(detail_lines) do
        add_line(line)
      end
    end
    add_line("")
  end

  -- LSP Semantic Tokens
  if inspect_info.semantic_tokens and #inspect_info.semantic_tokens > 0 then
    add_line("Semantic Tokens", "@function.lua")
    for _, entry in ipairs(inspect_info.semantic_tokens) do
      local hl_group = entry.opts.hl_group or "none"
      local hl_link = entry.opts.hl_group_link or "none"
      local priority = entry.opts.priority or 0

      add_line(string.format(" • %s → %s (p:%d)", hl_group, hl_link, priority))

      -- Show detailed info
      local detail_lines = format_hl_details(hl_link)
      for _, line in ipairs(detail_lines) do
        add_line(line)
      end
    end
    add_line("")
  end

  -- Extmarks
  if inspect_info.extmarks and #inspect_info.extmarks > 0 then
    add_line("Extmarks", "@function.lua")
    for _, entry in ipairs(inspect_info.extmarks) do
      local hl_group = entry.opts.hl_group or "none"
      local ns_name = entry.ns and #entry.ns > 0 and entry.ns or "unknown"

      add_line(string.format(" • %s [%s]", hl_group, ns_name))

      -- Show detailed info
      local detail_lines = format_hl_details(hl_group)
      for _, line in ipairs(detail_lines) do
        add_line(line)
      end
    end
    add_line("")
  end

  -- Legacy Syntax groups
  if inspect_info.syntax and #inspect_info.syntax > 0 then
    add_line("Syntax", "@keyword.lua")
    for _, entry in ipairs(inspect_info.syntax) do
      local hl_group = entry.hl_group or "none"
      local hl_link = entry.hl_group_link or "none"

      add_line(string.format(" • %s → %s", hl_group, hl_link))

      -- Show detailed info
      local detail_lines = format_hl_details(hl_link)
      for _, line in ipairs(detail_lines) do
        add_line(line)
      end
    end
    add_line("")
  end

  -- No highlight information found
  if #lines == 0 then
    add_line("No highlight information found")
  end

  return lines, highlights
end

-- Apply highlights to buffer
local function apply_highlights(bufnr, ns, highlights)
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  for _, hl in ipairs(highlights) do
    vim.api.nvim_buf_add_highlight(bufnr, ns, hl.hl_group, hl.line, 0, -1)
  end
end

-- Main inspect function
-- opts: { auto_close = 4000, focusable = false } -- time in milliseconds or nil to disable
function M.inspect(opts)
  opts = opts or {}

  -- Toggle behavior: if inspector is already open, reopen with focus
  local should_focus = false
  if state.win_id and vim.api.nvim_win_is_valid(state.win_id) then
    -- Close existing window and reopen with focus
    vim.api.nvim_win_close(state.win_id, true)
    should_focus = true
    opts.auto_close = nil -- Disable auto-close when focused
  else
    -- First call - use provided options or defaults
    if opts.auto_close == nil then
      opts.auto_close = 4000
    end
  end

  local auto_close = opts.auto_close
  local focusable = should_focus or (opts.focusable == true)

  -- Get current window and buffer (support floating windows)
  local win_id = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_win_get_buf(win_id)

  -- Get cursor position (1-based)
  local pos = vim.api.nvim_win_get_cursor(win_id)
  local line, col = pos[1], pos[2]

  if not line or not col or line < 1 or col < 0 then
    vim.notify("Invalid cursor position: " .. tostring(line) .. ":" .. tostring(col), vim.log.levels.WARN)
    return
  end

  -- Get highlight info using modern API (0-based for vim.inspect_pos)
  local inspect_info = vim.inspect_pos(bufnr, line - 1, col)
  local lines, highlights = format_inspect_info(inspect_info)

  -- Create scratch buffer
  local popup_bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(popup_bufnr, 0, -1, false, lines)
  vim.bo[popup_bufnr].modifiable = false
  vim.bo[popup_bufnr].bufhidden = "wipe"
  vim.bo[popup_bufnr].filetype = "inspector"

  -- Apply highlights
  local ns = vim.api.nvim_create_namespace("inspect_highlight")
  apply_highlights(popup_bufnr, ns, highlights)

  -- Calculate window dimensions
  local width = 0
  for _, line_text in ipairs(lines) do
    width = math.max(width, #line_text)
  end
  width = math.min(width + 4, 80)
  local height = math.min(#lines + 1, 30)

  -- Create floating window
  local win_opts = {
    relative = "cursor",
    row = 1,
    col = 1,
    width = width,
    height = height,
    border = "rounded",
    title = string.format(" Inspector: %d:%d %s", line, col, focusable and "[Focus]" or ""),
    title_pos = "center",
    style = "minimal",
    focusable = focusable,
    zindex = 100,
  }

  local popup_win_id = vim.api.nvim_open_win(popup_bufnr, focusable, win_opts)

  -- Save state for toggle behavior
  state.win_id = popup_win_id
  state.bufnr = popup_bufnr

  -- Close function
  local close_fn = function()
    if vim.api.nvim_win_is_valid(popup_win_id) then
      vim.api.nvim_win_close(popup_win_id, true)
      state.win_id = nil
      state.bufnr = nil
    end
  end

  -- Keymaps for closing (q/Esc) - only if focusable
  if focusable then
    vim.keymap.set("n", "q", close_fn, { buffer = popup_bufnr, silent = true, nowait = true })
    vim.keymap.set("n", "<Esc>", close_fn, { buffer = popup_bufnr, silent = true, nowait = true })
  end

  -- Auto-cleanup state when window closes
  vim.api.nvim_create_autocmd("WinClosed", {
    pattern = tostring(popup_win_id),
    callback = function()
      state.win_id = nil
      state.bufnr = nil
    end,
    once = true,
  })

  -- Auto-close after specified time
  if auto_close and type(auto_close) == "number" and auto_close > 0 then
    vim.defer_fn(function()
      close_fn()
    end, auto_close)
  end
end

return M
