local cmd = vim.api.nvim_create_user_command

cmd("Home", Vreq("utils.gui").home, { desc = "Close all buffers and go to startpage" })
