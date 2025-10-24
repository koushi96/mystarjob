<script setup>
  import { reactive, ref, watch, onMounted } from 'vue';
  import ComponentButton from './ComponentButton.vue';

  const form = reactive({
    company: '',
    contactPerson: '',
    jobTitle: '',
    contactNumber: '',
    email: '',
    venue: '',
    date: ''
  });

  const errors = reactive({});
  const showModal = ref(false); // Modal state

  const exhibitionVenue = ref([]);

  onMounted(() => {
    fetchVenueData();
  });

  async function fetchVenueData() {
    try {
      const response = await fetch('http://localhost/backend/api/getVenue.php', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      const result = await response.json();

      if (!response.ok) {
        console.error('Server validation error:', result);
        alert('Something went wrong on the server.');
        return;
      }

      if (Array.isArray(result) && result.length > 0) {
        console.log('exhibitionVenue:', result);
        exhibitionVenue.value = result;
        //   Only call this after venue data exists
        fetchDateData();
      } else {
        console.warn('No venue data received.');
      }

    } catch (error) {
      console.error('Network error:', error);
      alert('Failed to load venues. Please try again later.');
    }
  }

  const exhibitionDate = ref([]);

  async function fetchDateData() {
    try {
      const response = await fetch('http://localhost/backend/api/getExhibitionDates.php', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      const result = await response.json();

      if (!response.ok) {
        console.error('Server validation error:', result);
        alert('Something went wrong on the server.');
        return;
      }

      console.log('exhibitionDate:', result);
      exhibitionDate.value = result; 

    } catch (error) {
      console.error('Network error:', error);
      alert('Failed to load venues. Please try again later.');
    }
  }

  const availableDates = ref([]);

  watch(() => form.venue, (newVenue) => {
    form.date = ''; // Reset date

    const selectedVenue = exhibitionVenue.value.find(v => v.venue_city === newVenue);

    if (selectedVenue) {
      const found = exhibitionDate.value.find(d => d.venue_id === selectedVenue.id);
      availableDates.value = found ? found.dates : [];
    } else {
      availableDates.value = [];
    }
  });

  const validateEmail = (email) => {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
  };

  async function handleSubmit() {
    Object.keys(errors).forEach((key) => (errors[key] = ''));

    if (!form.contactPerson) errors.contactPerson = "Contact person's name is required.";
    if (!form.contactNumber) errors.contactNumber = 'Contact number is required.';
    if (!form.email) {
      errors.email = 'Email is required.';
    } else if (!validateEmail(form.email)) {
      errors.email = 'Invalid email format.';
    }
    if (!form.company) errors.company = 'Company name is required.';
    if (!form.jobTitle) errors.jobTitle = 'Job title is required.';
    if (!form.venue) errors.venue = 'Exhibition venue is required.';
    if (!form.date) errors.date = 'Exhibition date is required.';

  // If no errors, POST to PHP API
    if (Object.values(errors).every((e) => !e)) {
      try {
        const response = await fetch('http://localhost/backend/api/exhibitorRegistration.php', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(form)
        });

        const result = await response.json();

        if (!response.ok) {
          console.error('Server validation error:', result);
          alert('Something went wrong on the server.');
          return;
        }

        console.log('Form submitted:', result);
        alert('Form submitted successfully!');

        // Reset form
        Object.keys(form).forEach((key) => {
          form[key] = '';
        });

      } catch (error) {
        console.error('Network error:', error);
        alert('Failed to submit form. Please try again later.');
      }
    }
  }

  function handleDateChange(event) {
    if (!form.venue) {
      showModal.value = true;
      form.date = '';
    }
  }
</script>

<template>
  <div class="mainLayout">
    <div class="titleDiv">
      <h3 class='title'>{{ $t('exhibitionHallRegistration.mainTitle') }}</h3>
    </div>
  </div>
  

  <form @submit.prevent="handleSubmit" class="contactForm">

    <div class="formGroup">
      <label for="company">{{ $t('exhibitionHallRegistration.companyLabel') }}</label>
      <input type="text" id="company" v-model="form.company" />
      <span v-if="errors.company" class="error">{{ errors.company }}</span>
    </div>

    <div class="formGroup">
      <label for="contactPerson">{{ $t('exhibitionHallRegistration.contactPersonLabel') }}</label>
      <input type="text" id="contactPerson" v-model="form.contactPerson" />
      <span v-if="errors.contactPerson" class="error">{{ errors.contactPerson }}</span>
    </div>
    
    <div class="formGroup">
      <label for="jobTitle">{{ $t('exhibitionHallRegistration.jobTitleLabel') }}</label>
      <input type="text" id="jobTitle" v-model="form.jobTitle" />
      <span v-if="errors.jobTitle" class="error">{{ errors.jobTitle }}</span>
    </div>

    <div class="formGroup">
      <label for="contactNumber">{{ $t('exhibitionHallRegistration.contactNumberLabel') }}</label>
      <input type="text" id="contactNumber" v-model="form.contactNumber" />
      <span v-if="errors.contactNumber" class="error">{{ errors.contactNumber }}</span>
    </div>

    <div class="formGroup">
      <label for="email">{{ $t('exhibitionHallRegistration.emailLabel') }}</label>
      <input type="email" id="email" v-model="form.email" />
      <span v-if="errors.email" class="error">{{ errors.email }}</span>
    </div>

<div class="formGroup">
  <label for="venue">{{ $t('exhibitionHallRegistration.venueLabel') }}</label>
  <select id="venue" v-model="form.venue">
    <option disabled value="">{{ $t('exhibitionHallRegistration.selectAVenueLabel') }}</option>
    <option 
      v-for="venue in $tm('exhibitionVenue')"
      :key="venue.id" 
      :value="venue.venue_city"
    >
      {{ venue.venue_city }}
    </option>
  </select>
  <span v-if="errors.venue" class="error">{{ errors.venue }}</span>
</div>

<div class="formGroup">
  <label for="date">{{ $t('exhibitionHallRegistration.dateLabel') }}</label>
  <select 
    id="date" 
    v-model="form.date"
    @click="handleDateChange"
  >
    <option disabled value="">{{ $t('exhibitionHallRegistration.selectADateLabel') }}</option>
    <option 
      v-for="date in availableDates" 
      :key="date" 
      :value="date"
    >
      {{ date }}
    </option>
  </select>
  <span v-if="errors.date" class="error">{{ errors.date }}</span>
</div>

<!-- Modal -->
<div v-if="showModal" class="modalBackdrop" @click.self="showModal = false">
  <div class="modalContent">
    <p>{{ $t('exhibitionHallRegistration.modalLabel') }}</p>
    <button @click="showModal = false">OK</button>
  </div>
</div>

    <!-- Submit button -->
    <div class="submitBtnWrapper">
      <ComponentButton :isExhibitor="true">{{ $t('exhibitionHallRegistration.submitButton') }}</ComponentButton>
      <ComponentButton :isExhibitor="false"  to="/">{{ $t('exhibitionHallRegistration.backToHome') }}</ComponentButton>
    </div>
  </form>
</template>



<style scoped>

.mainLayout {
  width: 100%;
  height: auto;
  display: flex;
  justify-content: center;
  align-items: center;
}

.titleDiv {
  width: 60%;
  height: auto;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
} 

.title {
  color: black;
  border: none;
  font-size: 4rem;
  font-height: 5rem;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 0px;
}

.contactForm {
  background: linear-gradient(135deg, #ffffff, #f4f7fc);
  padding: 3rem 2rem;
  border-radius: 12px;
  max-width: 800px;
  margin: 64px auto;
  color: #1a1a1a;
  border: 1px solid #e0e0e0;
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.08);
  display: grid;
  grid-template-columns: 1fr 1fr;
  row-gap: 1.5rem;
  column-gap: 2rem;
  font-family: 'Inter', sans-serif;
}

.fullWidth {
  grid-column: 1 / -1;
}

label {
  font-weight: 600;
  margin-bottom: 0.4rem;
  display: block;
  font-size: 1rem;
}

input,
textarea {
  width: 90%;
  padding: 0.75rem 1rem;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 1rem;
  background-color: #fff;
  transition: border 0.3s, box-shadow 0.3s;
  color: black;
}

input:focus,
textarea:focus {
  outline: none;
  border-color: green;
  box-shadow: 0 0 0 4px rgba(108, 235, 108, 0.2);
}

.formGroup {
  display: flex;
  flex-direction: column;
}

.error {
  color: #e74c3c;
  font-size: 0.85rem;
  margin-top: 0.25rem;
  font-weight: 500;
}

.submitBtnWrapper {
  grid-column: 1 / -1;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 1rem; 
  margin-top: 1.5rem;
}

select {
  width: 100%;
  padding: 0.75rem 1rem;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 1rem;
  background-color: #fff;
  color: black;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}

select:focus {
  outline: none;
  border-color: green;
  box-shadow: 0 0 0 4px rgba(108, 235, 108, 0.2);
}

/* Modal styles */
.modalBackdrop {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modalContent {
  background: #fff;
  padding: 2rem;
  border-radius: 8px;
  width: 90%;
  max-width: 400px;
  text-align: center;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.modalContent p {
  font-size: 1.1rem;
  margin-bottom: 1rem;
}

.modalContent button {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 0.6rem 1.2rem;
  border-radius: 4px;
  font-size: 1rem;
  cursor: pointer;
}
</style>
