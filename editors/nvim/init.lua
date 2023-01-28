-- init.lua 			| Plugin Initializer for `nvim`
-- @CodexLink 		| https://github.com/CodexLink
-- Description: This lua file only checks for the existence of the modules, as well as import them via `require`.

-- Step 1: Create a set of modules for us to import.
local required_modules = {
	"options",
	"plugins",
	"utils",
	"mappings" -- Contains `which-key.nvim`, which has to be declared after `plugins`.
}

-- Step 2, Final: Check them via for loop via require.
for _, module_name in ipairs(required_modules) do
	local success, module_instance = pcall(require, module_name)

	if (not success) then
		error("Importing module" ..
			_ ..
			" (" ..
			module_instance ..
			") has occured an error, it was either not installed or the location of these plugins were not correct.")
		return
	end
end
