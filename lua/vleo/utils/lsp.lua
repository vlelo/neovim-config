local M = {}

local lsp_group = vim.api.nvim_create_augroup("LspStartup", { clear = false })
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
		group = lsp_group,
  })
end

return M
