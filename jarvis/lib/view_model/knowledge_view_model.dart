import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:jarvis/model/knowledge.dart';
import 'package:jarvis/model/knowledge_list.dart';
import 'package:jarvis/model/knowledge_unit_list.dart';

import '../constant.dart';
import '../repository/knowledge_repository.dart';
import 'auth_view_model.dart';

class KnowledgeViewModel extends ChangeNotifier {
  final KnowledgeRepository knowledgeRepository;
  final AuthViewModel authViewModel;

  KnowledgeList? knowledgeList;
  bool isFetchingKnowledgeList = false;

  KnowledgeUnitList? knowledgeUnitList;
  bool isFetchingKnowledgeUnitList = false;

  bool isUploadingFile = false;
  bool isUploadingSuccess = true;

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
    if (isFetchingKnowledgeList) return;
    isFetchingKnowledgeList = true;

    notifyListeners();

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
    } catch (e) {
      print(e);
    } finally {
      isFetchingKnowledgeList = false;
      notifyListeners();
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

  Future<void> fetchKnowledgeUnitList(
      {int offset = 0,
      int limit = defaultLimitKb,
      required String knowledgeId}) async {
    if (isFetchingKnowledgeUnitList) return;
    isFetchingKnowledgeUnitList = true;
    notifyListeners();

    try {
      final fetchedList = await knowledgeRepository.fetchKnowledgeUnitList(
        user: authViewModel.user,
        knowledgeId: knowledgeId,
        offset: offset,
        limit: limit,
      );
      if (knowledgeList == null || fetchedList.meta.offset == 0) {
        knowledgeUnitList = fetchedList;
      } else {
        knowledgeUnitList?.data.addAll(fetchedList.data);
        knowledgeUnitList?.meta = fetchedList.meta;
      }
    } catch (e) {
      print(e);
    } finally {
      isFetchingKnowledgeUnitList = false;
      notifyListeners();
    }
  }

  Future<void> uploadLocalFile(
      {required String knowledgeId, required String path}) async {
    try {
      isUploadingFile = true;
      isUploadingSuccess = true;
      notifyListeners();

      final unit = await knowledgeRepository.uploadLocalFile(
          user: authViewModel.user, knowledgeId: knowledgeId, path: path);
      knowledgeUnitList?.data.add(unit);
    } catch (e) {
      isUploadingSuccess = false;
      print(e);
    } finally {
      isUploadingFile = false;
      notifyListeners();
    }
  }

  Future<void> uploadLocalFileWeb({
    required String knowledgeId,
    required String fileName,
    required Uint8List bytes,
  }) async {
    try {
      isUploadingFile = true;
      isUploadingSuccess = true;
      notifyListeners();

      final unit = await knowledgeRepository.uploadLocalFileWeb(
        user: authViewModel.user,
        knowledgeId: knowledgeId,
        fileName: fileName,
        bytes: bytes,
      );

      knowledgeUnitList?.data.add(unit);
    } catch (e) {
      isUploadingSuccess = false;
      print(e);
    } finally {
      isUploadingFile = false;
      notifyListeners();
    }
  }


  Future<void> uploadWebsite(
      {required String webUrl,
      required String unitName,
      required String knowledgeId}) async {
    try {
      isUploadingFile = true;
      isUploadingSuccess = true;
      notifyListeners();

      final unit = await knowledgeRepository.uploadWebsite(
          user: authViewModel.user,
          knowledgeId: knowledgeId,
          webUrl: webUrl,
          unitName: unitName);
      knowledgeUnitList?.data.add(unit);
    } catch (e) {
      isUploadingSuccess = false;
      print(e);
    } finally {
      isUploadingFile = false;
      notifyListeners();
    }
  }

  Future<void> uploadDataFromSlack(
      {required String name,
      required String workspace,
      required String token,
      required String knowledgeId}) async {
    try {
      print('name: $name, workspace: $workspace, token: $token');
      isUploadingFile = true;
      isUploadingSuccess = true;
      notifyListeners();

      final unit = await knowledgeRepository.uploadDataFromSlack(
          user: authViewModel.user,
          knowledgeId: knowledgeId,
          name: name,
          workspace: workspace,
          token: token);
      knowledgeUnitList?.data.add(unit);
    } catch (e) {
      isUploadingSuccess = false;
      print(e);
    } finally {
      isUploadingFile = false;
      notifyListeners();
    }
  }

  Future<void> uploadDataFromConfluence(
      {required String name,
      required String wikiPageUrl,
      required String username,
      required String accessToken,
      required String knowledgeId}) async {
    try {
      isUploadingFile = true;
      isUploadingSuccess = true;
      notifyListeners();

      final unit = await knowledgeRepository.uploadDataFromConfluence(
          user: authViewModel.user,
          knowledgeId: knowledgeId,
          name: name,
          wikiPageUrl: wikiPageUrl,
          username: username,
          accessToken: accessToken);
      knowledgeUnitList?.data.add(unit);
    } catch (e) {
      isUploadingSuccess = false;
      print(e);
    } finally {
      isUploadingFile = false;
      notifyListeners();
    }
  }
}
