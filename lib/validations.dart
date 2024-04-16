bool isFrontTextBackTextNotEmpty(String frontText, String backText) =>
    frontText.isNotEmpty && backText.isNotEmpty;

List<String> getTagsFromTagsString(String tagsString,
    {String delimeter = ','}) {
  List<String> tagsList = tagsString.split(delimeter);
  if (tagsList.length == 1 && tagsList.first == '') return [];
  return tagsList;
}
