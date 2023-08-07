
CharacterModel.fromMap(Map<String, dynamic> json):
id = json["id"],
name = json["name"],
status = json["status"],
species = json["species"],
gender = json["gender"],
origin = Location.fromMap(json["origin"]),
location = Location.fromMap(json["location"]),
image = json["image"],
url = json["url"];
}
