<template>
  <div id="home">
    <div id="background-div" class="page-holder bg-cover">
      
      <div class="container py-5">
        <header class="text-left text-white py-5">
          <h3 calss="mb-4 rounded" id="heading">
            <a href="#start-shopping" class="bg-white px-2 py-2 rounded">Start Shopping</a></h3>
            

        </header>
        </div>
        <hr />
        
    </div>
  </div>
  <!--display categories -->
    <div class="container">
          <div class="row">
            <div class="col-12 text-center">
              <h2 class="pt-3">Top Categories</h2>
            </div>
          </div>
          <div class="row">
            <div v-for="index in this.categorySize" :key="index" class="col-md-6 col-xl-4 xol-12 pt-3 justify-content-around d-flex">
              <CategoryBox :category="categories[index-1]" />
            </div>
          </div>
    </div>
  <!-- display top products -->
 
   <div class="container py-2">
    <div class="row">
      <div class="col-12 text-center">
        <h2 class="pt-3">Top Products</h2>
      </div>
   </div>

  <!-- display products -->
  <div class="row">
    <div v-for="index in this.productSize" :key="index" class="col-md-6 col-xl-4 xol-12 pt-3 justify-content-around d-flex">
        <ProductBox :product="products[index-1]" />
      </div>
    </div>
  </div>
</template>

<script>
import ProductBox from '@/components/ProductBox.vue';
import CategoryBox from '@/components/CategoryBox.vue';
export default {
  name: 'HomeView',
  components: {ProductBox, CategoryBox},
  props: ["categories", "products"],
  data() {
    return {
      categorySize: 0,
      productSize: 0
    }
  },
  mounted() {
    this.categorySize = Math.min(6, this.categories.length);
    this.productSize = Math.min(8, this.products.length);
  }
  
};
</script>
<style>
.page-holder {
  min-height: 100vh;
}
.bg-cover {
  background-size: cover !important;
}
#background-div {
  background: url("../assets/How-to-start-an-online-clothing-boutique-header.jpg");
}
#heading {
  font-weight: 400;
}
</style>
