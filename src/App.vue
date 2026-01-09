<script setup lang="ts">
import { computed, ref, watchEffect } from 'vue'

import { imageUrl } from '@/utils'

const subjects = ['i', 'you', 'he', 'she', 'they'] as const

type Size = 'a-little' | 'a-lot'
type Subject = (typeof subjects)[number]

const leftBookSubject = ref<Subject>('you')
const leftBookSize = ref<Size>('a-little')
const rightBookSubject = ref<Subject>('i')
const rightBookSize = ref<Size>('a-lot')

const variation = new URLSearchParams(window.location.search)
  .get('v')
  ?.match(/(\w+)-said-(a-little|a-lot)-(\w+)-read-(a-little|a-lot)/)

if (variation) {
  leftBookSubject.value = variation[1] as Subject
  leftBookSize.value = variation[2] as Size
  rightBookSubject.value = variation[3] as Subject
  rightBookSize.value = variation[4] as Size
}

const bookId = computed(
  () =>
    `meme-${leftBookSubject.value}-said-${leftBookSize.value}-${rightBookSubject.value}-read-${rightBookSize.value}`
)

watchEffect(() => {
  const meme = `${leftBookSubject.value}-said-${leftBookSize.value}-${rightBookSubject.value}-read-${rightBookSize.value}`
  const newUrl = `${window.location.pathname}?v=${meme}`
  window.history.replaceState(null, '', newUrl)
})

const capitalize = (s: string) => s.charAt(0).toUpperCase() + s.slice(1)
</script>

<template>
  <div class="flex h-full min-h-screen place-items-center">
    <main class="container flex flex-col items-center gap-4 mx-auto">
      <div>
        <h1 class="text-4xl font-bold">Misunderstandings</h1>
        <div class="text-xs text-center text-gray-600">
          <p>Based on a meme, original author unknown.</p>
        </div>
      </div>

      <p>
        <select v-model="leftBookSubject" class="pl-1">
          <option v-for="subject in subjects" :value="subject" :key="subject">
            {{ capitalize(subject) }}
          </option>
        </select>

        said

        <select v-model="leftBookSize" class="pl-1">
          <option value="a-little">a little</option>
          <option value="a-lot">a lot</option>
        </select>

        and

        <select v-model="rightBookSubject" class="pl-1">
          <option v-for="subject in subjects" :value="subject" :key="subject">
            {{ capitalize(subject) }}
          </option>
        </select>

        read a

        <select v-model="rightBookSize" class="pl-1">
          <option value="a-little">little</option>
          <option value="a-lot">lot</option>
        </select>

        into it
      </p>

      <picture>
        <source :srcset="imageUrl(`${bookId}.avif`)" type="image/avif" />
        <source :srcset="imageUrl(`${bookId}.webp`)" type="image/webp" />
        <img
          :src="imageUrl(`${bookId}.png`)"
          :alt="bookId"
          class="p-4 border border-gray-300 shadow-lg max-w-96"
        />
      </picture>

      <div class="text-xs italic text-center text-gray-400">
        <p>Right click on image or tap to hold to save.</p>
      </div>
    </main>
  </div>
</template>
