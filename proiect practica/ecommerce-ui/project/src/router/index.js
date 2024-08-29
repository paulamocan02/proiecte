import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/HomeView.vue'
import AddCategory from '../views/Category/AddCategory'
import ourCategories from '../views/Category/ourCategories.vue'
import ProductPart from '../views/Product/ProductPart.vue'
import Admin from "../views/AdminPart.vue";
import AddProduct from "../views/Product/AddProduct";
import EditCategory from '@/views/Category/EditCategory.vue'
import EditProduct from '@/views/Product/EditProduct.vue'
import ShowDetails from '@/views/Product/ShowDetails.vue'
import ListProducts from '@/views/Category/ListProducts.vue'
import SignUp from '@/views/SignUp.vue'
import SignIn from '@/views/SignIn.vue'
import WishList from '@/views/Product/WishList.vue'
import CartPart from '@/views/CartPart.vue'

import CheckoutPart from '../views/CheckoutPart.vue';
import SuccessPart from '../views/payment/SuccessPart.vue'
import FailedPart from '../views/payment/FailedPart.vue'
const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
    // category detail page
  {
    path: '/category/show/:id',
    name: 'ListProducts',
    component: ListProducts
    
  },
  {
    path: '/admin/category/add',
    name: 'AddCategory',
    component: AddCategory
  },
  {
    path: '/admin/category',
    name: 'Category',
    component: ourCategories
  },
   // category edit
   {
    path: '/admin/category/:id',
    name: 'EditCategory',
    component: EditCategory
  },
   // admin home page
   {
    path: '/admin',
    name: 'Admin',
    component: Admin
  },
  {
    path: '/admin/product',
    name: 'ProductPart',
    component: ProductPart
  },
   // add product
   {
    path: '/admin/product/new',
    name: 'AddProduct',
    component: AddProduct
  },
    // product edit 
  {
    path: '/admin/product/:id',
    name: 'EditProduct',
    component: EditProduct
  },
   
    // show details of product
  {
    path: '/product/show/:id',
    name: 'ShowDetails',
    component: ShowDetails
  },

    // sign up and sign in
  {
    path: '/signup',
    name: 'SignUp',
    component: SignUp
  },
  {
    path: '/signin',
    name: 'SignIn',
    component: SignIn
  },

    // wishlist page
  {
    path: '/wishlist',
    name: 'WishList',
    component: WishList
  },

    // cart page
  {
    path: '/cart',
    name: 'Cart',
    component: CartPart
  },
  // sucess and fail pages
  {
    path: '/payment/success',
    name: 'PaymentSuccess',
    component: SuccessPart,
  },

  {
    path: '/payment/failed',
    name: 'PaymentFail',
    component: FailedPart,
  },

  // checkout

  {
    path: '/checkout',
    name: 'Checkout',
    component: CheckoutPart,
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router