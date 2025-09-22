return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = function()
      -- Retrieve the SYSTEM_APPEARANCE environment variable
      local system_appearance = os.getenv("SYSTEM_APPEARANCE")

      -- Determine the Catppuccin flavor based on system appearance
      local flavor = "mocha" -- Default to mocha
      if system_appearance == "light" then
        flavor = "latte"
      end

      -- Return the configuration table with the determined flavor
      return {
        flavour = flavor,
        background = {
          light = "latte",
          dark = "mocha",
        },
        auto_integrations = true,
      }
    end,
  },

  -- Configure LazyVim to load Catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
