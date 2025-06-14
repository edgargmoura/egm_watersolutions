import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL
const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

export interface ContactSubmission {
  name: string
  email: string
  phone?: string
  company?: string
  service_interest?: string
  message?: string
}

export async function submitContactForm(data: ContactSubmission) {
  const { data: result, error } = await supabase
    .from('contact_submissions')
    .insert([data])
    .select()

  if (error) {
    throw error
  }

  return result
}