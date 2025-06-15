import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL
const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables')
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false,
    detectSessionInUrl: false
  }
})

export interface ContactSubmission {
  name: string
  email: string
  phone?: string
  company?: string
  service_interest?: string
  message?: string
}

export async function submitContactForm(data: ContactSubmission) {
  try {
    // Ensure we're using the anonymous context with proper headers
    const { data: result, error } = await supabase
      .from('contact_submissions')
      .insert([{
        name: data.name,
        email: data.email,
        phone: data.phone || null,
        company: data.company || null,
        service_interest: data.service_interest || null,
        message: data.message || null
      }])
      .select()

    if (error) {
      console.error('Supabase error:', error)
      throw new Error(`Failed to submit form: ${error.message}`)
    }

    return result
  } catch (error) {
    console.error('Form submission error:', error)
    throw error
  }
}