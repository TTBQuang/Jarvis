enum Category {
  all('all', 'All'),
  business('business', 'Business'),
  career('career', 'Career'),
  chatbot('chatbot', 'Chatbot'),
  coding('coding', 'Coding'),
  education('education', 'Education'),
  fun('fun', 'Fun'),
  marketing('marketing', 'Marketing'),
  productivity('productivity', 'Productivity'),
  seo('seo', 'SEO'),
  writing('writing', 'Writing'),
  other('other', 'Other');

  final String apiValue;
  final String displayName;

  const Category(this.apiValue, this.displayName);

  static Category fromApiValue(String apiValue) {
    return Category.values.firstWhere(
          (category) => category.apiValue == apiValue,
      orElse: () => Category.all,
    );
  }
}