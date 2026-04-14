// Substitua pelas suas credenciais do Supabase
const SUPABASE_URL = 'https://ptjmpxiwynslgavedmcd.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB0am1weGl3eW5zbGdhdmVkbWNkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzYwOTI5NTgsImV4cCI6MjA5MTY2ODk1OH0.FVNPlB2H3PKRp4COigaNQrloxcSSHDGBLhuOj9ga0rc';

const _supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

export { _supabase };
