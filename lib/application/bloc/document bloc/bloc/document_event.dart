part of 'document_bloc.dart';

sealed class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object> get props => [];
}
class DocPickerInitial extends DocumentEvent{}

class DocUpdateEvent extends DocumentEvent{}