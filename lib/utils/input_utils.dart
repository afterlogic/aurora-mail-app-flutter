import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/shared_ui/asset_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_color.dart';

class InputUtils {
  /// Returns InputDecoration with unlyme styles if useCustomInputStyles = true
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
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      suffixIcon: suffixIcon,
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
          EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
    );
  }

  /// Creates a custom section (section header) for the unlyme theme
  static Widget buildUnlymeSection({
    required BuildContext context,
    required String title,
    TextStyle? textStyle,
  }) {
    if (!BuildProperty.useCustomInputStyles) {
      // Standard ContactTile
      return Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: ListTile(
          title: Text(
            title,
            style: textStyle ?? Theme.of(context).textTheme.titleLarge,
          ),
        ),
      );
    }

    // Custom style for unlyme
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

  /// A wrapper for a TextField with unlyme styles
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

  /// Wrapper for TextFormField with unlyme styles
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

  /// Creates a container with a custom style for grouping inputs
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

  /// Creates a custom DropdownButtonFormField with unlyme styles
  static Widget buildUnlymeDropdownFormField<T>({
    required T? value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    required String Function(T) itemBuilder,
    Widget Function(T)? itemWidget,
    String? labelText,
    String? hintText,
    bool enabled = true,
    String? Function(T?)? validator,
    bool isExpanded = true,
    bool isDense = false,
    List<Widget> Function(BuildContext)? selectedItemBuilder,
    Color backgroundColor = Colors.white,
  }) {
    if (!BuildProperty.useCustomInputStyles) {
      return DropdownButtonFormField<T>(
        value: value,
        items: items
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: itemWidget != null
                      ? itemWidget(item)
                      : Text(itemBuilder(item)),
                ))
            .toList(),
        onChanged: enabled ? onChanged : null,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
        isExpanded: isExpanded,
        isDense: isDense,
        selectedItemBuilder: selectedItemBuilder,
      );
    }

    return DropdownButtonFormField<T>(
      value: value,
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: itemWidget != null
                    ? itemWidget(item)
                    : Text(
                        itemBuilder(item),
                        style:
                            TextStyle(color: AppColor.primary, fontSize: 14.0),
                      ),
              ))
          .toList(),
      onChanged: enabled ? onChanged : null,
      validator: validator,
      dropdownColor: backgroundColor,
      icon: Icon(Icons.arrow_drop_down,
          color: AppColor.inputPlaceholder, size: 20),
      decoration: getUnlymeInputDecoration(
        labelText: labelText,
        hintText: hintText,
        contentPadding: isDense
            ? EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0)
            : EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
      ),
      isExpanded: isExpanded,
      isDense: isDense,
      selectedItemBuilder: selectedItemBuilder ??
          (context) {
            return items.map((item) {
              return Text(
                itemBuilder(item),
                style: TextStyle(color: AppColor.primary, fontSize: 14.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            }).toList();
          },
    );
  }

  /// Creates a custom DropDownButton with unlyme styles (without a form)
  static Widget buildUnlymeDropdown<T>({
    required T? value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    required String Function(T) itemBuilder,
    String? hint,
    bool enabled = true,
    bool isExpanded = false,
    bool isDense = false,
    Color backgroundColor = Colors.white,
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
      height: 52.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
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
        dropdownColor: backgroundColor,
      ),
    );
  }

  /// Creates a custom ContactPrimaryInput with anonymous styles
  static Widget buildUnlymePrimaryInput<T>({
    required String label,
    required void Function(T?) onChanged,
    required T selectedValue,
    required List<String> options,
    required T Function(String) optionsToValue,
    required TextEditingController primaryTextCtrl,
    TextInputType? keyboardType,
    Color backgroundColor = Colors.white,
  }) {
    if (!BuildProperty.useCustomInputStyles) {
      // Standard style
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

    // Custom unlyme style
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
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
                  dropdownColor: backgroundColor,
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
                    fillColor: backgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Creates a custom Date Picker with unlyme styles
  static Widget buildUnlymeDatePicker({
    required BuildContext context,
    required TextEditingController controller,
    required String labelText,
    required VoidCallback onTap,
    bool enabled = true,
    Widget? suffixIcon,
  }) {
    if (!BuildProperty.useCustomInputStyles) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GestureDetector(
          onTap: enabled ? onTap : null,
          child: AbsorbPointer(
            child: TextField(
              controller: controller,
              enabled: enabled,
              decoration: InputDecoration(
                labelText: labelText,
                alignLabelWithHint: true,
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: AbsorbPointer(
          child: TextFormField(
            controller: controller,
            enabled: enabled,
            decoration: getUnlymeInputDecoration(
              labelText: labelText,
              suffixIcon: suffixIcon ??
                  Transform.scale(
                    scale: 0.4,
                    child: AssetSvgIcon(
                      showSvg: true,
                      svgPath:
                          '${BuildProperty.image_dir}/contacts/birthday.svg',
                      iconData: Icons.calendar_today,
                      width: 20,
                      height: 20,
                      color: AppColor.inputPlaceholder,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }

  /// Creates a custom Date Picker with anonymous styles using InputDecorator
  static Widget buildUnlymeInputDecorator({
    required BuildContext context,
    required String labelText,
    required VoidCallback onTap,
    Widget? child,
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: InputDecorator(
        isEmpty: child == null,
        decoration: BuildProperty.useCustomInputStyles
            ? InputDecoration(
                labelText: labelText,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide:
                      BorderSide(color: AppColor.inputBorder, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide:
                      BorderSide(color: AppColor.inputBorder, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide:
                      BorderSide(color: AppColor.inputBorder, width: 1.0),
                ),
                labelStyle: TextStyle(color: AppColor.inputPlaceholder),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              )
            : InputDecoration(
                labelText: labelText,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
        child: child,
      ),
    );
  }
}
