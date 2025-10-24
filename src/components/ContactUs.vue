<script setup>
  import { reactive, ref } from 'vue';
  import ComponentButton from './ComponentButton.vue';
  import data from '../common/data.json';

  const form = reactive({
    name: '',
    country: '',
    contact: '',
    email: '',
    company: '',
    jobTitle: '',
    inquiries: '',
  });

  const errors = reactive({});

  const validateEmail = (email) => {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
  };

  async function handleSubmit() {
    Object.keys(errors).forEach((key) => (errors[key] = ''));

    // Validation (same as before)
    if (!form.name) errors.name = 'Name is required.';
    if (!form.country) errors.country = 'Country is required.';
    if (!form.contact) errors.contact = 'Contact number is required.';
    if (!form.email) {
      errors.email = 'Email is required.';
    } else if (!validateEmail(form.email)) {
      errors.email = 'Invalid email format.';
    }
    if (!form.company) errors.company = 'Company is required.';
    if (!form.jobTitle) errors.jobTitle = 'Job title is required.';
    if (!form.inquiries) errors.inquiries = 'Inquiries are required.';

    // If no errors, POST to PHP API
    if (Object.values(errors).every((e) => !e)) {
      try {
        const response = await fetch('http://localhost/backend/api/contact.php', {
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
</script>

<template>
  <section id="contact-us">
    <div class="mainLayout">
      <div class="titleDiv">
        <h3 class='title'>{{data.contactUs.mainTitle}}</h3>
      </div>
    </div>
  

  <form @submit.prevent="handleSubmit" class="contactForm">
    <div class="formGroup">
      <label for="name">{{data.contactUs.nameLabel}}</label>
      <input type="text" id="name" v-model="form.name" />
      <span v-if="errors.name" class="error">{{ errors.name }}</span>
    </div>

    <div class="formGroup">
      <label for="country">{{data.contactUs.countryLabel}}</label>
      <input type="text" id="country" v-model="form.country" />
      <span v-if="errors.country" class="error">{{ errors.country }}</span>
    </div>

    <div class="formGroup">
      <label for="contact">{{data.contactUs.contactNumberLabel}}</label>
      <input type="text" id="contact" v-model="form.contact" />
      <span v-if="errors.contact" class="error">{{ errors.contact }}</span>
    </div>

    <div class="formGroup">
      <label for="email">{{data.contactUs.emailLabel}}</label>
      <input type="email" id="email" v-model="form.email" />
      <span v-if="errors.email" class="error">{{ errors.email }}</span>
    </div>

    <div class="formGroup">
      <label for="company">{{data.contactUs.companyLabel}}</label>
      <input type="text" id="company" v-model="form.company" />
      <span v-if="errors.company" class="error">{{ errors.company }}</span>
    </div>

    <div class="formGroup">
      <label for="jobTitle">{{data.contactUs.jobTitleLabel}}</label>
      <input type="text" id="jobTitle" v-model="form.jobTitle" />
      <span v-if="errors.jobTitle" class="error">{{ errors.jobTitle }}</span>
    </div>

    <!-- Full width textarea -->
    <div class="formGroup fullWidth">
      <label for="inquiries">{{data.contactUs.inquiriesLabel}}</label>
      <textarea id="inquiries" rows="4" v-model="form.inquiries"></textarea>
      <span v-if="errors.inquiries" class="error">{{ errors.inquiries }}</span>
    </div>

    <!-- Submit button -->
    <div class="submitBtnWrapper">
      <ComponentButton 
          :isExhibitor="true"
      >
          {{data.contactUs.buttonName}}
      </ComponentButton>
    </div>
  </form>
  </section>
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
  text-align: center;
  margin-top: 1.5rem;
}
</style>
