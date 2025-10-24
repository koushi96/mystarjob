<script setup>
import { reactive, ref, watch, onMounted } from 'vue';
import ComponentButton from './ComponentButton.vue';
import data from '../common/data.json';

const form = reactive({
  company: '',
  contactPerson: '',
  jobTitle: '',
  contactNumber: '',
  email: '',
  venue: '',
  date: '',
  slotTime: ''
});

const errors = reactive({});
const showModal = ref(false);

const exhibitionVenue = ref([]);
const sessionTypes = ref([]);
const sessionDates = ref([]);
const availableSlots = ref([]);

const selectedType = ref('');
const selectedVenueId = ref('');
const selectedDate = ref('');
const selectedSlotId = ref(null);

onMounted(async () => {
  await fetchSessionTypes();
  await fetchVenueData();
});

async function fetchVenueData() {
  try {
    const response = await fetch('http://localhost/backend/api/getVenue.php', {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' },
    });

    const result = await response.json();

    if (!response.ok) {
      console.error('Server validation error:', result);
      alert('Something went wrong on the server.');
      return;
    }

    if (Array.isArray(result) && result.length > 0) {
      exhibitionVenue.value = result;
      //   Removed fetchDateData() – no more bad request here
    } else {
      console.warn('No venue data received.');
    }
  } catch (error) {
    console.error('Network error:', error);
    alert('Failed to load venues. Please try again later.');
  }
}

async function fetchSessionTypes() {
  try {
    const res = await fetch('http://localhost/backend/api/getSessionType.php');
    const data = await res.json();
    sessionTypes.value = data;
  } catch (err) {
    console.error(err);
  }
}

watch([selectedType, selectedVenueId], async ([newType, newVenue]) => {
  selectedDate.value = '';
  form.date = '';
  availableSlots.value = [];
  form.slotTime = '';
  sessionDates.value = [];

  if (!newType || !newVenue) return;

  try {
    console.log("Fetching exhibition dates for:", newType, newVenue);
    const res = await fetch(
      `http://localhost/backend/api/getExhibitionDates.php?type_id=${newType}&venue_id=${newVenue}`
    );
    const data = await res.json();
    sessionDates.value = Array.isArray(data) ? data : [];
  } catch (err) {
    console.error('Error fetching session dates:', err);
    sessionDates.value = [];
  }
});

watch(selectedDate, async (newDate) => {
  form.slotTime = '';
  availableSlots.value = [];

  if (newDate && selectedType.value && selectedVenueId.value) {
    try {
      const res = await fetch(
        `http://localhost/backend/api/getAvailableSlots.php?type_id=${selectedType.value}&venue_id=${selectedVenueId.value}&session_date=${newDate}`
      );
      const data = await res.json();

      if (Array.isArray(data)) {
        availableSlots.value = data;
        console.log("koushi availableSlots.value : ", availableSlots.value)
      } else {
        console.error("Invalid slot response:", data);
        availableSlots.value = [];
      }

    } catch (err) {
      console.error("Error fetching available slots:", err);
    }
  }
});

watch(selectedVenueId, (val) => {
  form.venue = val || '';
});
watch(selectedDate, (val) => {
  form.date = val || '';
});


const validateEmail = (email) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);

async function handleSubmit() {
  Object.keys(errors).forEach(key => (errors[key] = ''));

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
  if (!form.slotTime) errors.slotTime = 'Please select a time slot.';

  if (Object.values(errors).every(e => !e)) {
    try {
        const response = await fetch('http://localhost/backend/api/sendSessions.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            company: form.company,
            contact_person: form.contactPerson,
            job_title: form.jobTitle,
            contact_number: form.contactNumber,
            email: form.email,
            session_type_id: selectedType.value,
            venue_id: selectedVenueId.value,
            session_date: selectedDate.value,
            slot_time: form.slotTime
        }),
        });

        const result = await response.json();
        console.log("Server response:", result);

        if (!response.ok) {
        console.error('Server error:', result);
        alert(result.error || 'Server returned an error.');
        return;
        }

      alert('Form submitted successfully!');
      Object.keys(form).forEach(key => (form[key] = ''));
      selectedType.value = '';
      selectedVenueId.value = '';
      selectedDate.value = '';
      availableSlots.value = [];
      sessionDates.value = [];
    } catch (error) {
      console.error('Network error:', error);
      alert('Failed to submit form. Please try again later.');
    }
  }
}

function handleDateChange() {
  if (!form.venue) {
    showModal.value = true;
    selectedDate.value = '';
  }
}
</script>


<template>
  <div class="mainLayout">
    <div class="titleDiv">
      <h3 class='title'>{{data.reservation.mainTitle}}</h3>
    </div>
  </div>

  <form @submit.prevent="handleSubmit" class="contactForm">
    <div class="formGroup">
      <label for="company">{{data.reservation.companyLabel}}</label>
      <input type="text" id="company" v-model="form.company" />
      <span v-if="errors.company" class="error">{{ errors.company }}</span>
    </div>

    <div class="formGroup">
      <label for="contactPerson">{{data.reservation.contactPersonLabel}}</label>
      <input type="text" id="contactPerson" v-model="form.contactPerson" />
      <span v-if="errors.contactPerson" class="error">{{ errors.contactPerson }}</span>
    </div>

    <div class="formGroup">
      <label for="jobTitle">{{data.reservation.jobTitleLabel}}</label>
      <input type="text" id="jobTitle" v-model="form.jobTitle" />
      <span v-if="errors.jobTitle" class="error">{{ errors.jobTitle }}</span>
    </div>

    <div class="formGroup">
      <label for="contactNumber">{{data.reservation.contactNumberLabel}}</label>
      <input type="text" id="contactNumber" v-model="form.contactNumber" />
      <span v-if="errors.contactNumber" class="error">{{ errors.contactNumber }}</span>
    </div>

    <div class="formGroup">
      <label for="email">{{data.reservation.emailLabel}}</label>
      <input type="email" id="email" v-model="form.email" />
      <span v-if="errors.email" class="error">{{ errors.email }}</span>
    </div>

    <div class="formGroup">
      <label for="sessionType">{{data.reservation.selectASession}}</label>
      <select v-model="selectedType">
        <option disabled value="">Select session type</option>
        <option v-for="t in sessionTypes" :key="t.id" :value="t.id">
          {{ t.type_name }}
        </option>
      </select>
    </div>

    <div class="formGroup">
      <label for="venue">{{data.reservation.venueLabel}}</label>
      <select v-model="selectedVenueId">
        <option disabled value="">Select venue</option>
        <option v-for="v in exhibitionVenue" :key="v.id" :value="v.id">
          {{ v.venue_city }}
        </option>
      </select>
      <span v-if="errors.venue" class="error">{{ errors.venue }}</span>
    </div>

    <div class="formGroup">
      <label for="date">{{data.reservation.dateLabel}}</label>
      <select v-model="selectedDate" @change="handleDateChange">
        <option disabled value="">{{data.reservation.selectADateLabel}}</option>
        <option v-for="d in sessionDates" :key="d" :value="d">
          {{ d }}
        </option>
      </select>
      <span v-if="errors.date" class="error">{{ errors.date }}</span>
    </div>

    <div class="formGroup">
    <label for="slotTime">{{data.reservation.availableSlotsLabel}}</label>
    <select v-model="form.slotTime" id="slotTime">
        <option disabled value="">{{data.reservation.selectTimeSlot}}</option>
        <option
        v-for="(slot, index) in availableSlots"
        :key="index"
        :value="slot"
        >
        {{ slot }}
        </option>
    </select>
    <span v-if="errors.slotTime" class="error">{{ errors.slotTime }}</span>
    </div>

    <!-- Modal -->
    <div v-if="showModal" class="modalBackdrop" @click.self="showModal = false">
      <div class="modalContent">
        <p>{{data.reservation.modalLabel}}</p>
        <button @click="showModal = false">OK</button>
      </div>
    </div>

    <!-- Submit button -->
    <div class="submitBtnWrapper">
      <ComponentButton :isExhibitor="true">{{data.reservation.submitButton}}</ComponentButton>
      <ComponentButton :isExhibitor="false"  to="/">{{data.reservation.backToHome}}</ComponentButton>
    </div>

  </form>
</template>

<style scoped>
.mainLayout {
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}
.titleDiv {
  width: 60%;
  display: flex;
  justify-content: center;
  align-items: center;
}
.title {
  color: black;
  font-size: 4rem;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 0;
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
  color: black;
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
  text-align: center;
}
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
  max-width: 400px;
  text-align: center;
}
.modalContent button {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 0.6rem 1.2rem;
  border-radius: 4px;
  cursor: pointer;
}
</style>
