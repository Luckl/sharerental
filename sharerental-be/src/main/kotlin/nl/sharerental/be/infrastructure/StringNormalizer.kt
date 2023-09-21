package nl.sharerental.be.infrastructure

import java.text.Normalizer
import java.util.regex.Pattern


val pattern = Pattern.compile("[^a-zA-Z0-9]")

private fun String.removeSpecialCharacters() = pattern.matcher(this).replaceAll("")

fun String.normalizeString() =
    Normalizer.normalize(this, Normalizer.Form.NFKD).lowercase().removeSpecialCharacters().replace(" ", "-")
