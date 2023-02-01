vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.jsx", "*.tsx", "*.vue", "*.html", "*.css", "*.scss" },
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.shiftwidth = 2
		vim.opt.softtabstop = 2
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function()
		local client = vim.lsp.get_active_clients()[1]
		if client then
			if client.server_capabilities.documentFormattingProvider then
				vim.lsp.buf.format()
			end
		end
	end,
})
