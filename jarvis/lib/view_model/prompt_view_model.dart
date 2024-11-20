import 'package:flutter/material.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/prompt.dart';
import 'package:jarvis/model/prompt_list.dart';
import 'package:jarvis/repository/auth_repository.dart';
import 'package:jarvis/view/prompt_library/prompt_library_bottom_sheet.dart';
import 'package:jarvis/view_model/auth_view_model.dart';

import '../model/category.dart';
import '../repository/prompt_repository.dart';

class PromptViewModel extends ChangeNotifier {
  final PromptRepository promptRepository;
  final AuthRepository authRepository;
  final AuthViewModel authViewModel;

  PromptViewModel({
    required this.authRepository,
    required this.promptRepository,
    required this.authViewModel,
  });

  PromptList? publicPromptList;
  String errorMessagePublicTab = '';

  PromptList? privatePromptList;
  String errorMessagePrivateTab = '';

  PromptType currentType = PromptType.private;

  Future<void> fetchPublicPrompt({
    String? query,
    int? offset,
    int? limit,
    Category? category,
    bool? isFavorite,
  }) async {
    try {
      PromptList newPromptList = await promptRepository.fetchPrompts(
        user: authViewModel.user,
        query: query,
        offset: offset,
        limit: limit,
        category: category?.apiValue,
        isFavorite: isFavorite,
        isPublic: true,
      );

      if (newPromptList.offset == 0) {
        publicPromptList = newPromptList;
      } else {
        publicPromptList = publicPromptList?.copyWith(
          total: newPromptList.total,
          hasNext: newPromptList.hasNext,
          offset: newPromptList.offset,
          limit: newPromptList.limit,
          items: publicPromptList?.items ?? []
            ..addAll(newPromptList.items),
        );
      }

      errorMessagePublicTab = '';

      notifyListeners();
    } catch (e) {
      print(e.toString());
      if (e.toString().contains('Unauthorized') &&
          authViewModel.user.userToken != null) {
        String accessToken = await authRepository.refreshToken(
          authViewModel.user,
        );
        if (accessToken.isNotEmpty) {
          authViewModel.user.userToken?.accessToken = accessToken;
          notifyListeners();
          fetchPublicPrompt(
              query: query,
              offset: offset,
              limit: limit,
              category: category,
              isFavorite: isFavorite);
        }
      } else {
        errorMessagePublicTab = 'Failed to fetch prompts';
        notifyListeners();
      }
    }
  }

  Future<void> fetchPrivatePrompts({
    String? query,
    int? offset,
    int? limit,
    Category? category,
    bool? isFavorite,
  }) async {
    try {
      PromptList newPromptList = await promptRepository.fetchPrompts(
        user: authViewModel.user,
        query: query,
        offset: offset,
        limit: limit,
        category: category?.apiValue,
        isFavorite: isFavorite,
        isPublic: false,
      );

      if (newPromptList.offset == 0) {
        privatePromptList = newPromptList;
      } else {
        privatePromptList = privatePromptList?.copyWith(
          total: newPromptList.total,
          hasNext: newPromptList.hasNext,
          offset: newPromptList.offset,
          limit: newPromptList.limit,
          items: privatePromptList?.items ?? []
            ..addAll(newPromptList.items),
        );
      }

      errorMessagePrivateTab = '';
      notifyListeners();
    } catch (e) {
      print(e.toString());
      if (e.toString().contains('Unauthorized') &&
          authViewModel.user.userToken != null) {
        String accessToken = await authRepository.refreshToken(
          authViewModel.user,
        );
        if (accessToken.isNotEmpty) {
          authViewModel.user.userToken?.accessToken = accessToken;
          notifyListeners();
          fetchPrivatePrompts(
              query: query,
              offset: offset,
              limit: limit,
              category: category,
              isFavorite: isFavorite);
        }
      } else {
        errorMessagePrivateTab = 'Failed to fetch prompts';
        notifyListeners();
      }
    }
  }

  Future<void> addPromptToFavorites({required String promptId}) async {
    try {
      promptRepository.addPromptToFavorites(
        promptId: promptId,
        user: authViewModel.user,
      );
    } catch (e) {
      print(e.toString());
      if (e.toString().contains('Unauthorized') &&
          authViewModel.user.userToken != null) {
        String accessToken = await authRepository.refreshToken(
          authViewModel.user,
        );
        if (accessToken.isNotEmpty) {
          authViewModel.user.userToken?.accessToken = accessToken;
          notifyListeners();
          addPromptToFavorites(promptId: promptId);
        }
      }
    }
  }

  Future<void> removePromptFromFavorites({required String promptId}) async {
    try {
      promptRepository.removePromptFromFavorites(
        promptId: promptId,
        user: authViewModel.user,
      );
    } catch (e) {
      print(e.toString());
      if (e.toString().contains('Unauthorized') &&
          authViewModel.user.userToken != null) {
        String accessToken = await authRepository.refreshToken(
          authViewModel.user,
        );
        if (accessToken.isNotEmpty) {
          authViewModel.user.userToken?.accessToken = accessToken;
          notifyListeners();
          removePromptFromFavorites(promptId: promptId);
        }
      }
    }
  }

  Future<void> deletePrompt({required String promptId}) async {
    try {
      await promptRepository.deletePrompt(
        promptId: promptId,
        user: authViewModel.user,
      );

      privatePromptList = privatePromptList?.copyWith(
        items: privatePromptList!.items
            .where((item) => item.id != promptId)
            .toList(),
      );

      notifyListeners();
    } catch (e) {
      print(e.toString());
      if (e.toString().contains('Unauthorized') &&
          authViewModel.user.userToken != null) {
        String accessToken = await authRepository.refreshToken(
          authViewModel.user,
        );
        if (accessToken.isNotEmpty) {
          authViewModel.user.userToken?.accessToken = accessToken;
          notifyListeners();
          deletePrompt(promptId: promptId);
        }
      }
    }
  }

  Future<void> updatePrompt(Prompt prompt) async {
    try {
      await promptRepository.updatePrompt(
        user: authViewModel.user,
        prompt: prompt,
      );

      privatePromptList = privatePromptList?.copyWith(
        items: privatePromptList!.items.map((item) {
          return item.id == prompt.id ? prompt : item;
        }).toList(),
      );

      notifyListeners();
    } catch (e) {
      print(e.toString());
      if (e.toString().contains('Unauthorized') &&
          authViewModel.user.userToken != null) {
        String accessToken = await authRepository.refreshToken(
          authViewModel.user,
        );
        if (accessToken.isNotEmpty) {
          authViewModel.user.userToken?.accessToken = accessToken;
          notifyListeners();
          updatePrompt(prompt);
        }
      }
    }
  }

  Future<void> createPrompt(
      {required String category,
      required String content,
      required String description,
      required bool isPublic,
      required String language,
      required String title}) async {
    try {
      await promptRepository.createPrompt(
          category: category,
          content: content,
          description: description,
          isPublic: isPublic,
          language: language,
          title: title);

      isPublic ? fetchPublicPrompt() : fetchPrivatePrompts();
      notifyListeners();
    } catch (e) {}
  }

  void changePromptType(PromptType type) {
    this.currentType = type;
    type == PromptType.public
        ? fetchPublicPrompt(limit: defaultLimit)
        : fetchPrivatePrompts(limit: defaultLimit);
    notifyListeners();
  }
}
