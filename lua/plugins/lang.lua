local language_support = Config.options.language_support

-- Language support disabled
if language_support == false then
	return {}
end

-- Language support enabled explicitly or implicitly
if language_support == true or language_support == nil then
	return { import = 'plugins.lang' }
end

-- `language_support` option value is invalid
if type(language_support) ~= 'table' then
	Config.utils.error("Invalid type for `options.language_support`: " .. type(language_support))
	return {}
end

-- Language support enabled only for specified languages
if language_support.include then
	return vim.tbl_map(function(lang)
		return { import = 'plugins.lang.' .. lang }
	end, language_support.include)
end

-- Language support enabled for all languages except specified languages
if language_support.exclude then
	local excluded_langs = language_support.exclude
	excluded_langs = type(excluded_langs) == 'table' and excluded_langs or { excluded_langs }

	local module_paths = vim.fs.find(function(name, _)
		return name:match("%.lua$")
	end, { limit = math.huge, type = 'file', path = vim.fn.stdpath('config') .. "/lua/plugins/lang" })

	return vim.tbl_map(function(path)
		-- Get filename and trim `.lua` extension
		local lang = vim.fs.basename(path):sub(0, -5)
		return vim.tbl_contains(excluded_langs, lang) and { import = 'plugins.lang.' .. lang } or {}
	end, module_paths)
end

-- `language_support` is a table with invalid keys
Config.utils.error("Invalid `options.language_support` value: " .. vim.inspect(language_support) .. "\nLanguage specific support disabled")
return {}

