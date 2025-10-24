<script setup>
import { ref, computed, onMounted, watch } from 'vue';
import data from '../common/data.json';
import { resolveAsset } from '../common/commonFunctions.ts'

const images = import.meta.glob('../assets/hallLayout/*.{jpg,jpeg,png,webp}', { eager: true });
const imageList = Object.values(images).map(i => i.default);

const selectedOption = ref('');
const searchText = ref('');
const isDropdownOpen = ref(false);

// Filter options based on search
const filteredOptions = computed(() => {
  const search = searchText.value.toLowerCase()
  return data.directoryOptions.filter(option =>
    option.company.toLowerCase().includes(search)
  )
})

function selectOption(option) {
  selectedOption.value = `${option.company} — Plot ${option.boothNum}`
  searchText.value = ''
  isDropdownOpen.value = false
}

function toggleDropdown() {
  isDropdownOpen.value = !isDropdownOpen.value
}

function closeDropdown() {
  isDropdownOpen.value = false
}

onMounted(() => {
  document.addEventListener('click', (e) => {
    const container = document.querySelector('.custom-select')
    if (container && !container.contains(e.target)) {
      closeDropdown()
    }
  })
})

// Open dropdown when matches are found during typing
watch(searchText, (newVal) => {
  if (newVal && filteredOptions.value.length > 0) {
    isDropdownOpen.value = true
  }
})
</script>


<template>
    <div class="titleDiv">
        <h3 class='title'>Exhibition Hall Layout</h3>
        <div class="gallery">
            <img v-for="(img, index) in imageList" :key="index" :src="img" alt="Exhibition_Hall_Layout" />
        </div>
        <div class="hoverToView"> 
            <img :src="resolveAsset(data.exhibitionHallLayout.magnifyingGlassUrl)" alt='magnifying-glass'/>
            <p>Click to view</p>
        </div>
        <div class='directory'>
            <img :src="resolveAsset(data.exhibitionHallLayout.floorDirectoryUrl)" alt='floor_directory'/>
            <div class='searhDropdown'>
                <div class='directoryDropdown'>
                    <label for="search">Find companies' plot number :</label>
                    <div class="custom-select">
                        <div class="dropdown-wrapper">
                            <input
                            type="text"
                            id="search"
                            v-model="searchText"
                            @focus="isDropdownOpen = true"
                            :placeholder="selectedOption || 'Search or select company...'"
                            class="search-dropdown-input"
                            />
                            <ul v-show="isDropdownOpen" class="dropdown-list">
                            <li
                                v-for="option in filteredOptions"
                                :key="option.boothNum"
                                @click.stop="selectOption(option)"
                            >
                                {{ option.company }} — Plot {{ option.boothNum }}
                            </li>
                            <li v-if="filteredOptions.length === 0" class="no-match">No matches found</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>


<style scoped>
.titleDiv {
    width: auto;
    height: auto;
    margin-bottom: 64px;
}

.title {
    color: black;
    border: none;
    font-size: 4rem;
    font-height: 5rem;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 36px;
}

.gallery {
    width: auto;
    display: flex;
    flex-wrap: wrap;
    gap: 2rem 6rem;
    justify-content: center;
    margin-bottom: 36px;
}

.gallery img {
    height: 15rem;              
    width: auto;
    object-fit: contain;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    cursor: pointer;
    border-radius: 12px;
}

.gallery img:hover {
    transform: scale(1.8);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.hoverToView {
    width: auto;
    display: flex;
    justify-content: center;
    align-items: center;
}

.hoverToView img{
    height: 2rem;              
    width: auto;
    object-fit: contain;
}

.hoverToView p{
    margin-left: 0.5rem;
    height: 2rem;              
    width: auto;
    color: black;
    border: none;
    font-size: 1.2rem;
    font-weight: 500;
}

.directory {
    width: auto;
    display: flex;
    justify-content: center;
    align-items: start;
}

.directory img{
    height: 30rem;              
    width: auto;
    object-fit: contain;
}

.searhDropdown {
    width: 50%;
    height: auto;
    display: flex;
    flex-direction: row;
    justify-content: start;
    align-items: start;
}

.directoryDropdown{
    width: 100%;
    height: auto;
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
}

.directoryDropdown #dropdown {
    margin-left: 1rem;
    width: 50%;
    padding: 0.5rem 1rem;
    background-color: white;
    color: black;
    border: 3px solid green;
    border-radius: 8px;
    font-weight: 500;
    font-size: 1rem;
}

.search-box {
    margin-left: 1rem;
    margin-bottom: 0.75rem;
    width: 48%;
    padding: 0.5rem 1rem;
    border: 2px solid #ccc;
    border-radius: 6px;
    font-size: 1rem;
    font-weight: 400;
    color: black;
}

.custom-select {
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    width: 50%;
    margin-left: 1rem;
}

.dropdown-wrapper {
    position: relative;
    width: 100%;
}

.search-dropdown-input {
    width: 100%;
    padding: 0.6rem 1rem;
    border: 3px solid green;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 500;
    color: black;
    background-color: white;
}

.dropdown-list {
    position: absolute;
    top: 100%;
    left: 0;
    width: 100%;
    max-height: 350px;
    background: white;
    border: 1px solid #ccc;
    border-radius: 0 0 8px 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
    z-index: 10;
}

.dropdown-list li {
    padding: 0.6rem 1rem;
    cursor: pointer;
}

.dropdown-list li:hover {
    background-color: #f0f0f0;
}

.no-match {
    padding: 0.6rem 1rem;
    color: #888;
}

</style>
