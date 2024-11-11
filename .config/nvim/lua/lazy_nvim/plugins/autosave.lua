return {
    {
        "brianhuster/autosave.nvim",
        event="InsertEnter",
        opts = {
            enabled = true,
            disable_inside_paths = {vim.fn.stdpath('config')}
        } -- Configuration here
    },
}
