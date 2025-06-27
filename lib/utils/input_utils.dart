import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_color.dart';

class InputUtils {
  /// Возвращает InputDecoration с unlyme стилями если useCustomInputStyles = true
  static InputDecoration getUnlymeInputDecoration({
    String? labelText,
    String? hintText,
    Widget? suffixIcon,
    EdgeInsets? contentPadding,
  }) {
    if (!BuildProperty.useCustomInputStyles) {
      return InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
      );
    }

    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColor.inputBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColor.inputBorder, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColor.inputBorder, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColor.inputBorder, width: 1.0),
      ),
      labelStyle: TextStyle(color: AppColor.inputPlaceholder),
      hintStyle: TextStyle(color: AppColor.inputPlaceholder),
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    );
  }

  /// Создает кастомную секцию (заголовок раздела) для unlyme темы
  static Widget buildUnlymeSection({
    required BuildContext context,
    required String title,
    TextStyle? textStyle,
  }) {
    if (!BuildProperty.useCustomInputStyles) {
      // Стандартный ContactTile
      return Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: ListTile(
          title: Text(
            title,
            style: textStyle ?? Theme.of(context).textTheme.headline6,
          ),
        ),
      );
    }

    // Кастомный стиль для unlyme
    return Container(
      margin: EdgeInsets.only(top: 24.0, bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColor.sectionBackground,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        title.toUpperCase(),
        style: textStyle ??
            TextStyle(
              color: AppColor.sectionText,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
      ),
    );
  }

  /// Обертка для TextField с unlyme стилями
  static Widget buildUnlymeTextField({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    bool enabled = true,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    FocusNode? focusNode,
    bool obscureText = false,
    int? maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      focusNode: focusNode,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: getUnlymeInputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }

  /// Обертка для TextFormField с unlyme стилями
  static Widget buildUnlymeTextFormField({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    bool enabled = true,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    FocusNode? focusNode,
    bool obscureText = false,
    int? maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      validator: validator,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      focusNode: focusNode,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: getUnlymeInputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }

  /// Создает контейнер с кастомным стилем для группировки инпутов
  static Widget buildUnlymeInputGroup({
    required List<Widget> children,
    EdgeInsets? padding,
    EdgeInsets? margin,
  }) {
    if (!BuildProperty.useCustomInputStyles) {
      return Column(children: children);
    }

    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: padding ?? EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColor.inputGroupBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppColor.inputGroupBorder,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  /// Создает кастомный DropdownButtonFormField с unlyme стилями
  static Widget buildUnlymeDropdownFormField<T>({
    required T? value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    required String Function(T) itemBuilder,
    String? labelText,
    String? hintText,
    bool enabled = true,
    String? Function(T?)? validator,
  }) {
    if (!BuildProperty.useCustomInputStyles) {
      return DropdownButtonFormField<T>(
        value: value,
        items: items
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(itemBuilder(item)),
                ))
            .toList(),
        onChanged: enabled ? onChanged : null,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
      );
    }

    return DropdownButtonFormField<T>(
      value: value,
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  itemBuilder(item),
                  style: TextStyle(color: AppColor.primary),
                ),
              ))
          .toList(),
      onChanged: enabled ? onChanged : null,
      validator: validator,
      dropdownColor: Colors.white,
      icon: Icon(Icons.arrow_drop_down, color: AppColor.inputPlaceholder),
      decoration: getUnlymeInputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }

  /// Создает кастомный DropdownButton с unlyme стилями (без формы)
  static Widget buildUnlymeDropdown<T>({
    required T? value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    required String Function(T) itemBuilder,
    String? hint,
    bool enabled = true,
    bool isExpanded = false,
    bool isDense = false,
  }) {
    if (!BuildProperty.useCustomInputStyles) {
      return DropdownButton<T>(
        value: value,
        items: items
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(itemBuilder(item)),
                ))
            .toList(),
        onChanged: enabled ? onChanged : null,
        hint: hint != null ? Text(hint) : null,
        isExpanded: isExpanded,
        isDense: isDense,
        underline: SizedBox.shrink(),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColor.inputBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColor.inputBorder,
          width: 1.0,
        ),
      ),
      child: DropdownButton<T>(
        value: value,
        items: items
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    itemBuilder(item),
                    style: TextStyle(color: AppColor.primary),
                  ),
                ))
            .toList(),
        onChanged: enabled ? onChanged : null,
        hint: hint != null
            ? Text(hint, style: TextStyle(color: AppColor.inputPlaceholder))
            : null,
        isExpanded: isExpanded,
        isDense: isDense,
        underline: SizedBox.shrink(),
        icon: Icon(Icons.arrow_drop_down, color: AppColor.inputPlaceholder),
        dropdownColor: Colors.white,
      ),
    );
  }

  /// Создает кастомный ContactPrimaryInput с unlyme стилями
  static Widget buildUnlymePrimaryInput<T>({
    required String label,
    required void Function(T?) onChanged,
    required T selectedValue,
    required List<String> options,
    required T Function(String) optionsToValue,
    required TextEditingController primaryTextCtrl,
    TextInputType? keyboardType,
  }) {
    if (!BuildProperty.useCustomInputStyles) {
      // Стандартный стиль
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.all(0),
          ),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: DropdownButton<T>(
                  items: options
                      .map((o) => DropdownMenuItem(
                            value: optionsToValue(o),
                            child: Text(o),
                          ))
                      .toList(),
                  underline: SizedBox.shrink(),
                  value: selectedValue,
                  onChanged: onChanged,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: primaryTextCtrl,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(0)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Кастомный unlyme стиль
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColor.inputBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColor.inputBorder,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColor.inputPlaceholder,
              fontSize: 12.0,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: AppColor.inputBorder,
                    width: 0.5,
                  ),
                ),
                child: DropdownButton<T>(
                  items: options
                      .map((o) => DropdownMenuItem(
                            value: optionsToValue(o),
                            child: Text(
                              o,
                              style: TextStyle(color: AppColor.primary),
                            ),
                          ))
                      .toList(),
                  underline: SizedBox.shrink(),
                  value: selectedValue,
                  onChanged: onChanged,
                  isDense: true,
                  icon: Icon(Icons.arrow_drop_down,
                      color: AppColor.inputPlaceholder, size: 20),
                  dropdownColor: Colors.white,
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: TextFormField(
                  controller: primaryTextCtrl,
                  keyboardType: keyboardType,
                  style: TextStyle(color: AppColor.primary),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
