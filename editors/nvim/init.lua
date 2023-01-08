-- init.lua 			| Plugin Initializer for `nvim`
-- Version 0.1.0  | Since 11/01/2022
-- @CodexLink 		| https://github.com/CodexLink
-- Description: This lua file only checks for the existence of the modules, as well as import them via `require`.

-- Step 1: Create a set of modules for us to import.
local required_modules = {
	"keybinds",
	"options",
	"plugins"
}

-- Step 2, Final: Check them via for loop via require.
for _, module_name in ipairs(required_modules) do
	success, module_instance = pcall(require, module_name)

	if (not success) then
		error("Importing module" .. _ .. " (" .. module_instance .. ") has occured an error, it was either not installed or the location of these plugins were not correct.")
		return
	end
end
