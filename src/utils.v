fn string_default_if_empty(possibly_empty string, default_string string) string {
	if possibly_empty == '' {
		return default_string
	}
	return possibly_empty
}
