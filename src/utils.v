module main

import x.vweb

fn string_default_if_empty(possibly_empty string, default_string string) string {
	if possibly_empty == '' {
		return default_string
	}
	return possibly_empty
}

fn get_compressible_file_extension(file_name string) !string {
	for extension in plausible_gzip {
		if file_name.ends_with(extension) {
			return extension
		}
	}
	return error('This file should not be compressed')
}

fn get_content_type(extension string) string {
	return vweb.mime_types[extension]
}
