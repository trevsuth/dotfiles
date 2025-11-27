local M = {}

local palette = {
  bg = "#0a1620",
  panel = "#0d1f2d",
  grid = "#133040",
  text = "#e4f1f9",
  muted = "#6c7b86",
  cyan = "#4ff3ff",
  teal = "#2eb5d8",
  amber = "#ffb25a",
  danger = "#f35e5e",
  cursorline = "#102535",
}

local function apply_highlights()
  local hl = vim.api.nvim_set_hl
  hl(0, "Normal", { fg = palette.text, bg = palette.bg })
  hl(0, "NormalFloat", { fg = palette.text, bg = palette.panel })
  hl(0, "FloatBorder", { fg = palette.cyan, bg = palette.panel })
  hl(0, "WinSeparator", { fg = palette.grid, bg = palette.bg })
  hl(0, "LineNr", { fg = palette.muted, bg = palette.bg })
  hl(0, "CursorLineNr", { fg = palette.amber, bg = palette.cursorline, bold = true })
  hl(0, "CursorLine", { bg = palette.cursorline })
  hl(0, "Visual", { bg = palette.grid })
  hl(0, "StatusLine", { fg = palette.text, bg = palette.panel })
  hl(0, "StatusLineNC", { fg = palette.muted, bg = palette.panel })
  hl(0, "Pmenu", { fg = palette.text, bg = palette.panel, blend = 0 })
  hl(0, "PmenuSel", { fg = palette.bg, bg = palette.cyan })
  hl(0, "Search", { fg = palette.bg, bg = palette.amber })
  hl(0, "IncSearch", { fg = palette.bg, bg = palette.teal })
  hl(0, "DiagnosticError", { fg = palette.danger })
  hl(0, "DiagnosticWarn", { fg = palette.amber })
  hl(0, "DiagnosticInfo", { fg = palette.cyan })
  hl(0, "DiagnosticHint", { fg = palette.teal })
end

function M.setup()
  apply_highlights()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("expanse_hud_colors", { clear = true }),
    callback = apply_highlights,
  })
end

return M
