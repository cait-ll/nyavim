require("packer").startup(function(use)
	use({
		"wbthomason/packer.nvim",
		"nvim-lua/plenary.nvim",
		"norcalli/nvim-colorizer.lua",
		"nvim-tree/nvim-web-devicons",
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"mfussenegger/nvim-dap",
		"simrat39/rust-tools.nvim",
		"jose-elias-alvarez/typescript.nvim",
		"p00f/clangd_extensions.nvim",
		"windwp/nvim-ts-autotag",
		"mrjones2014/legendary.nvim",
		"folke/which-key.nvim",
		"RRethy/nvim-base16",
		"goolord/alpha-nvim",
		"folke/twilight.nvim",
		"folke/tokyonight.nvim",
		"ziontee113/icon-picker.nvim",
		"pianocomposer321/consolation.nvim",
		"rcarriga/nvim-dap-ui",
		"lukas-reineke/indent-blankline.nvim",
		"stevearc/dressing.nvim",
		"anuvyklack/pretty-fold.nvim",
		"nvim-pack/nvim-spectre",
		"windwp/nvim-autopairs",
		"jghauser/mkdir.nvim",
		"ahmedkhalf/project.nvim",
		"nvim-treesitter/nvim-treesitter-refactor",
		"nvim-treesitter/nvim-treesitter-context",
		"theHamsta/nvim-dap-virtual-text",
		"williamboman/mason-lspconfig.nvim",
		"jayp0521/mason-nvim-dap.nvim",
		"onsails/lspkind.nvim",
		"tanvirtin/vgit.nvim",
		"folke/neodev.nvim",
		"j-hui/fidget.nvim",
		"nvim-lualine/lualine.nvim",
		"tiagovla/scope.nvim",
		"akinsho/bufferline.nvim",
		"nvim-tree/nvim-tree.lua",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-emoji",
		"saadparwaiz1/cmp_luasnip",
		"molleweide/LuaSnip-snippets.nvim",
	})
	use({
		"L3MON4D3/LuaSnip",
		tag = "v1.*",
		run = "make install_jsregexp",
	})
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	if Is_bootstrap then
		require("packer").sync()
	end
end)

require("plugin_config")
