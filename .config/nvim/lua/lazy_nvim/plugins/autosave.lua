return {
    {
        "brianhuster/autosave.nvim",
        event="InsertEnter",
        opts = {
            enabled = false,
            disable_inside_paths = {vim.fn.stdpath('config')}
            } -- Configuration here
    },
}
