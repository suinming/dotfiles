return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"
    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode { mode_text = {} },
      status.component.git_branch(),
      status.component.git_diff(),
      status.component.file_info {
        filename = { modify = ":p:~" },
      },
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.treesitter(),
      { provider = " %4l/%L:%-3c %3p%%" },
      status.component.mode { surround = { separator = "right" } },
    }
    return opts
  end,
}
