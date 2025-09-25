import '../../../helper/all_imports.dart';

class AllPromptModel {
  final List<AllPromptData>? data;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  AllPromptModel({
    this.data,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  AllPromptModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => AllPromptData.fromJson(e as Map<String, dynamic>)).toList(),
        responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {'data': data?.map((e) => e.toJson()).toList(), 'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime};
}

class AllPromptData {
  final String? catId;
  final String? name;
  final String? img;
  final List<Prompts>? prompts;

  AllPromptData({
    this.catId,
    this.name,
    this.img,
    this.prompts,
  });

  AllPromptData.fromJson(Map<String, dynamic> json)
      : catId = json['cat_id'] as String?,
        name = json['name'] as String?,
        img = json['img'] as String?,
        prompts = (json['prompts'] as List?)?.map((dynamic e) => Prompts.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'cat_id': catId, 'name': name, 'img': img, 'prompts': prompts?.map((e) => e.toJson()).toList()};
}

class Prompts {
  final String? promptId;
  final String? catId;
  final String? colorCode;
  final String? stringMatch;
  final String? name;
  GlobalKey key = GlobalKey();
  final String? description;
  final String? question;
  final String? img;
  final String? mostlyUse;
  final String? isPremium;
  final List<TagTypeList>? tagTypeList;
  final List<FormFields>? formFields;

  Prompts({
    this.promptId,
    this.catId,
    this.colorCode,
    this.name,
    this.description,
    this.stringMatch,
    this.question,
    this.img,
    this.mostlyUse,
    this.tagTypeList,
    this.formFields,
    this.isPremium,
  });

  Prompts.fromJson(Map<String, dynamic> json)
      : promptId = json['prompt_id'] as String?,
        catId = json['cat_id'] as String?,
        colorCode = json['color_code'] as String?,
        name = json['name'] as String?,
        description = json['description'] as String?,
        question = json['question'] as String?,
        img = json['img'] as String?,
        mostlyUse = json['mostly_use'] as String?,
        stringMatch = json['string_match'] as String?,
        isPremium = json['is_premium'] as String?,
        tagTypeList = (json['tag_type_list'] as List?)?.map((dynamic e) => TagTypeList.fromJson(e as Map<String, dynamic>)).toList(),
        formFields = (json['form_fields'] as List?)?.map((dynamic e) => FormFields.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'prompt_id': promptId,
        'cat_id': catId,
        'string_match': stringMatch,
        'color_code': colorCode,
        'name': name,
        'description': description,
        'question': question,
        'img': img,
        'mostly_use': mostlyUse,
        'is_premium': isPremium,
        'tag_type_list': tagTypeList?.map((e) => e.toJson()).toList(),
        'form_fields': formFields?.map((e) => e.toJson()).toList()
      };
}

class TagTypeList {
  final String? tagTypeId;
  final String? tagField;
  final String? tagType;
  final List<TagList>? tagList;

  TagTypeList({
    this.tagTypeId,
    this.tagField,
    this.tagType,
    this.tagList,
  });

  TagTypeList.fromJson(Map<String, dynamic> json)
      : tagTypeId = json['tag_type_id'] as String?,
        tagField = json['tag_field'] as String?,
        tagType = json['tag_type'] as String?,
        tagList = (json['tag_list'] as List?)?.map((dynamic e) => TagList.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'tag_type_id': tagTypeId, 'tag_field': tagField, 'tag_type': tagType, 'tag_list': tagList?.map((e) => e.toJson()).toList()};
}

class TagList {
  final String? tag;
  String? isDefaultSelect;

  TagList({
    this.tag,
    this.isDefaultSelect,
  });

  TagList.fromJson(Map<String, dynamic> json)
      : tag = json['tag'] as String?,
        isDefaultSelect = json['is_default_select'] as String?;

  Map<String, dynamic> toJson() => {'tag': tag, 'is_default_select': isDefaultSelect};
}

class FormFields {
  final String? promptId;
  final String? promptFormId;
  final String? fieldType;
  final String? isOptional;
  final String? name;
  var value;
  final dynamic placeholder;
  final List<DropdownValue>? dropdownValue;

  FormFields({
    this.promptId,
    this.promptFormId,
    this.fieldType,
    this.name,
    this.placeholder,
    this.value = "",
    this.isOptional,
    this.dropdownValue,
  });

  FormFields.fromJson(Map<String, dynamic> json)
      : promptId = json['prompt_id'] as String?,
        promptFormId = json['prompt_form_id'] as String?,
        fieldType = json['field_type'] as String?,
        name = json['name'] as String?,
        isOptional = json['is_optional'] as String?,
        placeholder = json['placeholder'],
        dropdownValue = (json['dropdown_value'] as List?)?.map((dynamic e) => DropdownValue.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'prompt_id': promptId,
        'is_optional': isOptional,
        'prompt_form_id': promptFormId,
        'field_type': fieldType,
        'name': name,
        'placeholder': placeholder,
        'dropdown_value': dropdownValue?.map((e) => e.toJson()).toList()
      };
}

class DropdownValue {
  final String? formDropdownId;
  final String? promptFormId;
  final String? nameEn;
  final String? name;

  DropdownValue({
    this.formDropdownId,
    this.promptFormId,
    this.nameEn,
    this.name,
  });

  DropdownValue.fromJson(Map<String, dynamic> json)
      : formDropdownId = json['form_dropdown_id'] as String?,
        promptFormId = json['prompt_form_id'] as String?,
        nameEn = json['name_en'] as String?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'form_dropdown_id': formDropdownId, 'prompt_form_id': promptFormId, 'name_en': nameEn, 'name': name};
}
