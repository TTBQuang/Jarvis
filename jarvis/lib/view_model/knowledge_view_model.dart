import 'package:flutter/material.dart';
import 'package:jarvis/model/knowledge.dart';
import 'package:jarvis/model/knowledge_list.dart';

import '../constant.dart';
import '../repository/knowledge_repository.dart';
import 'auth_view_model.dart';

class KnowledgeViewModel extends ChangeNotifier {
  final KnowledgeRepository knowledgeRepository;
  final AuthViewModel authViewModel;

  KnowledgeList? knowledgeList;
  bool isFetching = false;

  KnowledgeViewModel(
      {required this.knowledgeRepository, required this.authViewModel});

  Future<void> createKnowledge(String name, String description) async {
    try {
      final knowledge = await knowledgeRepository.createKnowledge(
        name: name,
        description: description,
        user: authViewModel.user,
      );

      knowledgeList?.data.insert(0, knowledge);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchKnowledgeList(
      {int offset = 0, int limit = defaultLimitKb, String query = ''}) async {
    if (isFetching) return;
    isFetching = true;

    try {
      final fetchedList = await knowledgeRepository.fetchKnowledgeList(
        user: authViewModel.user,
        offset: offset,
        limit: limit,
        query: query,
      );

      if (knowledgeList == null || fetchedList.meta.offset == 0) {
        knowledgeList = fetchedList;
      } else {
        knowledgeList?.data.addAll(fetchedList.data);
        knowledgeList?.meta = fetchedList.meta;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isFetching = false;
    }
  }

  Future<void> deleteKnowledge(String knowledgeId) async {
    try {
      await knowledgeRepository.deleteKnowledge(
        user: authViewModel.user,
        id: knowledgeId,
      );
      knowledgeList?.data.removeWhere((element) => element.id == knowledgeId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
