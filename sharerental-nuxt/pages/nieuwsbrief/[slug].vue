<script setup lang="ts">

import {BlogApi} from "~/schemas/openapi/blog";
import SrCtaLessor from "~/components/SrCtaLessor.vue";

const route = useRoute();
const $blogApi: BlogApi = useNuxtApp().$blogApi;

const slug = Array.isArray(route.params.slug) ? route.params.slug[0] : route.params.slug;

const {data: item} = await useAsyncData(slug, () => $blogApi.getBlogPost({slug}))


</script>

<template>
  <div>
    <div class="md:max-w-[1240px] md:mx-auto">
      <div v-html="item?.html"></div>
    </div>
  </div>
  <sr-cta-lessor></sr-cta-lessor>
</template>
<style>

h1, h2, h3 {
  margin-bottom: 15px;
}

h1 {
  font-size: 2em;
  font-weight: bold;
}

h2 {
  font-size: 1.75em;
  font-weight: bold;
  padding-bottom: 5px;
}

h3 {
  font-size: 1.5em;
}

p {
  margin-bottom: 15px;
}

a {
  text-decoration: none;
}

/* List Styles */
ul {
  margin-bottom: 20px;
  padding-left: 20px;
}

ul li {
  margin-bottom: 10px;
}

/* Table Styles */
table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
}

th, td {
  padding: 10px;
  border: 1px solid #ddd;
  text-align: left;
}

th {
  background-color: #f2f2f2;
  color: #2c3e50;
}

td {
  background-color: #fff;
}

thead {
  color: white;
}

/* Blockquote Styles */
blockquote {
  margin: 20px 0;
  padding: 10px 20px;
  background-color: #f9f9f9;
  border-left: 5px solid #003f19;
  font-style: italic;
  color: #555;
}

/* Button-like Links */
.sb-banner a {
  display: inline-block;
  padding: 10px 20px;
  background-color: #003f19;
  color: white;
  border-radius: 5px;
  text-align: center;
  font-size: 1em;
}

.sb-banner a:hover {
  background-color: #003f19;
}

/* Media (Iframe) Styling */
iframe {
  border: 0;
  margin-bottom: 20px;
}

/* Fine-tuning for layout */
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

/* Responsive Styling */
@media (max-width: 768px) {
  h1 {
    font-size: 1.5em;
  }

  h2 {
    font-size: 1.4em;
  }

  h3 {
    font-size: 1.2em;
  }

  table, th, td {
    font-size: 0.9em;
  }

  ul {
    padding-left: 15px;
  }
}

</style>
