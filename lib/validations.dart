List<String> getTagsFromTagsString(String tagsString,
    {String separater = ','}) {
  List<String> tagsList = tagsString.split(separater);
  tagsList = tagsList.map((e) => e.trim()).toList();
  if (tagsList.length == 1 && tagsList.first == '') return [];
  return tagsList;
}
