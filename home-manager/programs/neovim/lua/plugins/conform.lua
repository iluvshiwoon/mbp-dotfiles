local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		liquid = { "prettier" },
		lua = { "stylua" },
		python = { "isort", "black" },
		nixfmt = { "nixfmt" },
		C = { "astyle" },
	},
})

conform.formatters.nixfmt = {
    command = "/nix/store/95drg5x0ybrk8596md334ihdm5l6d04k-nixfmt-0.5.0/bin/nixfmt"
}
