-- colorsheme.lua	 | Plugin spec for the 'gruvbox' (ellisonleao/gruvbox.nvim), used for the package manager lazy.nvim"
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- [1] Higher priority is required for the colorscheme, as stated by the author of the package manager.

return {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- Load the theme.
        vim.cmd([[colorscheme oxocarbon]])
    end
}
