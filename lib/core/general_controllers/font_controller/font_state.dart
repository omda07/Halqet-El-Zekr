import 'package:equatable/equatable.dart';

abstract class FontState extends Equatable {
  const FontState();
}

class FontInitial extends FontState {
  @override
  List<Object> get props => [];
}

class SaveFontSizeLoadingState extends FontState {
  @override
  List<Object> get props => [];
}

class SaveFontSizeSuccessState extends FontState {
  @override
  List<Object> get props => [];
}

class SaveFontSizeErrorState extends FontState {
  final String message;

  const SaveFontSizeErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class SaveDuaaFontSizeLoadingState extends FontState {
  @override
  List<Object> get props => [];
}

class SaveDuaaFontSizeSuccessState extends FontState {
  @override
  List<Object> get props => [];
}

class SaveDuaaFontSizeErrorState extends FontState {
  final String message;

  const SaveDuaaFontSizeErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class SaveHadethFontSizeLoadingState extends FontState {
  @override
  List<Object> get props => [];
}

class SaveHadethFontSizeSuccessState extends FontState {
  @override
  List<Object> get props => [];
}

class SaveHadethFontSizeErrorState extends FontState {
  final String message;

  const SaveHadethFontSizeErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class GetFontSizeLoadingState extends FontState {
  @override
  List<Object> get props => [];
}

class GetFontSizeSuccessState extends FontState {
  @override
  List<Object> get props => [];
}
