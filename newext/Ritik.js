document.addEventListener('DOMContentLoaded', () => {
    // Select the form element
    const form = document.getElementById('registrationForm');

    // Add event listener for form submission
    form.addEventListener('submit', (event) => {
        event.preventDefault(); // Prevent the default form submission

        // Create an object to hold the form data
        const formData = {
            name: form.elements['name'].value,
            id: form.elements['id'].value,
            designation: form.elements['designation'].value,
            school: form.elements['school'].value,
            department: form.elements['department'].value,
            qualification: form.elements['qualification'].value,
            contact_number: form.elements['contact_number'].value,
            email: form.elements['email'].value,
        };

        // Clear the console
        console.clear();

        // Display the form data object in a formatted manner
        console.log('Form Data:');
        console.table(formData); // Displays the formData object in a table format

        // Alternatively, if you prefer a plain object view:
        // console.log('Form Data:', formData);

        // Optionally, you can add more handling for the form data here
    });
});
