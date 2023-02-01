local cmp_groups = {
	CmpItemAbbrDeprecated = { fg = "#545c7e", bg = "NONE", strikethrough = true },
	CmpItemAbbrMatch = { fg = "#7aa2f7", bg = "NONE", bold = true },
	CmpItemAbbrMatchFuzzy = { fg = "#7aa2f7", bg = "NONE", bold = true },
	CmpItemMenu = { fg = "#bb9af7", bg = "NONE", italic = true },

	CmpItemKindField = { fg = "#c0caf5", bg = "#f7768e" },
	CmpItemKindProperty = { fg = "#c0caf5", bg = "#f7768e" },
	CmpItemKindEvent = { fg = "#c0caf5", bg = "#f7768e" },

	CmpItemKindText = { fg = "#b4f9f8", bg = "#41a6b5" },
	CmpItemKindEnum = { fg = "#b4f9f8", bg = "#41a6b5" },
	CmpItemKindKeyword = { fg = "#b4f9f8", bg = "#41a6b5" },

	CmpItemKindConstant = { fg = "#ff9e64", bg = "#e0af68" },
	CmpItemKindConstructor = { fg = "#ff9e64", bg = "#e0af68" },
	CmpItemKindReference = { fg = "#ff9e64", bg = "#e0af68" },

	CmpItemKindFunction = { fg = "#c0caf5", bg = "#9d7cd8" },
	CmpItemKindStruct = { fg = "#c0caf5", bg = "#9d7cd8" },
	CmpItemKindClass = { fg = "#c0caf5", bg = "#9d7cd8" },
	CmpItemKindModule = { fg = "#c0caf5", bg = "#9d7cd8" },
	CmpItemKindOperator = { fg = "#c0caf5", bg = "#9d7cd8" },

	CmpItemKindVariable = { fg = "#565f89", bg = "#414868" },
	CmpItemKindFile = { fg = "#565f89", bg = "#414868" },

	CmpItemKindUnit = { fg = "#c0caf5", bg = "#ff9e64" },
	CmpItemKindSnippet = { fg = "#c0caf5", bg = "#ff9e64" },
	CmpItemKindFolder = { fg = "#c0caf5", bg = "#ff9e64" },

	CmpItemKindMethod = { fg = "#a9b1d6", bg = "#3d59a1" },
	CmpItemKindValue = { fg = "#a9b1d6", bg = "#3d59a1" },
	CmpItemKindEnumMember = { fg = "#a9b1d6", bg = "#3d59a1" },

	CmpItemKindInterface = { fg = "#565f89", bg = "#73daca" },
	CmpItemKindColor = { fg = "#565f89", bg = "#73daca" },
	CmpItemKindTypeParameter = { fg = "#565f89", bg = "#73daca" },
}

for k, v in pairs(cmp_groups) do
	vim.api.nvim_set_hl(0, k, v)
end
