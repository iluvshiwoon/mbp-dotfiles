require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["<C-k>"] = "move_selection_previous",
                ["<C-j>"] = "move_selection_next",
                ["<C-q>"] = require('telescope.actions').smart_send_to_qflist + require('telescope.actions').open_qflist,}
        }
    },
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		}
	}
})

require('telescope').load_extension('fzf')

