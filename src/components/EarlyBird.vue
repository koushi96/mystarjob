<script setup>
    import data from '../common/data.json';
    import { resolveAsset } from '../common/commonFunctions.ts'
</script>

<template>
  <div class='header'>
    <div class='leftSide'>
        <img :src="resolveAsset(data.earlyBird.findTheRightTalentUrl)" alt="findTheRightTalent" />
    </div>
    <div class='rightSide'>
        <img :src="resolveAsset(data.earlyBird.earlyBirdUrl)" alt="earlyBird" />
    </div>
    
  </div>
</template>

<style scoped>
.header {
    width: auto;
    height: auto;
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items:center;
}

.leftSide {
    width: 50%;
    height: auto;
}

.leftSide img {
    width: 60%;
    height: auto;
    object-fit: contain;
}

.rightSide {
    width: 50%;
    height: auto;
}

.rightSide img {
    width: 60%;
    height: auto;
    object-fit: contain;
}

@media (max-width: 767px) {
    .header {
        flex-direction: column;
    }

    .leftSide {
        width: 100%;
        height: auto;
    }

    .leftSide img {
        width: 90%;
        height: auto;
        object-fit: contain;
    }

    .rightSide {
        width: 100%;
        height: auto;
    }

    .rightSide img {
        width: 90%;
        height: auto;
        object-fit: contain;
    }
}

</style>