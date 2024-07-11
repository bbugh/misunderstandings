<script setup lang="ts">
import { computed, ref } from 'vue'

import { imageUrl } from '@/utils'

const sizes = ['small', 'big'] as const
const subjects = ['i', 'you', 'he', 'she', 'they'] as const

type Size = (typeof sizes)[number]
type Subject = (typeof subjects)[number]

const leftBookSubject = ref<Subject>('you')
const leftBookSize = ref<Size>('small')

const rightBookSubject = ref<Subject>('i')
const rightBookSize = ref<Size>('big')

const bookId = computed(
  () =>
    `meme-${leftBookSubject.value}-said-${leftBookSize.value}-${rightBookSubject.value}-read-${rightBookSize.value}`
)

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
          <option value="small">a little</option>
          <option value="big">a lot</option>
        </select>

        and

        <select v-model="rightBookSubject" class="pl-1">
          <option v-for="subject in subjects" :value="subject" :key="subject">
            {{ capitalize(subject) }}
          </option>
        </select>

        read a

        <select v-model="rightBookSize" class="pl-1">
          <option value="small">little</option>
          <option value="big">lot</option>
        </select>

        into it
      </p>

      <img
        :src="imageUrl(`${bookId}.png`)"
        :alt="bookId"
        class="p-4 border border-gray-300 shadow-lg max-w-96"
      />

      <div class="text-xs italic text-center text-gray-400">
        <p>Right click on image or tap to hold to save.</p>
      </div>
    </main>
  </div>
</template>
