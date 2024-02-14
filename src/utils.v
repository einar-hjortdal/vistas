module main

import x.vweb

fn string_default_if_empty(possibly_empty string, default_string string) string {
	if possibly_empty == '' {
		return default_string
	}
	return possibly_empty
}

const plausible_gzip = ['.html', '.css', '.js', '.json', '.xml', '.md']
const gzip_extension = '.gz'

fn may_be_compressed(file_name string) ?string {
	for extension in plausible_gzip {
		if file_name.ends_with(extension) {
			return extension
		}
	}
	return none
}

fn get_content_type(extension string) string {
	return vweb.mime_types[extension]
}
