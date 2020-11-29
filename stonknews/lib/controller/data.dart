import 'package:stonknews/model/category_model.dart';

List<CategoryModel> getCategories(){

  List<CategoryModel> category = new List<CategoryModel>();
  CategoryModel categoryModel = new CategoryModel();

  // Cat 1
  categoryModel.category = "Top of the Week";
  categoryModel.imageUrl = "https://cdn-images.farfetch-contents.com/14/52/50/28/14525028_22261442_300.jpg";
  category.add(categoryModel);

  categoryModel = new CategoryModel();

  return category;

}
