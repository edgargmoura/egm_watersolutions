/*
  # Fix Contact Submissions RLS Policy

  1. Security Updates
    - Drop existing INSERT policy for anonymous users
    - Create new INSERT policy with proper permissions for anonymous users
    - Ensure the policy allows all anonymous users to insert contact form data

  This migration fixes the RLS policy that was preventing anonymous users from submitting contact forms.
*/

-- Drop the existing INSERT policy if it exists
DROP POLICY IF EXISTS "Enable contact form submissions for anonymous users" ON contact_submissions;

-- Create a new INSERT policy that properly allows anonymous users to submit contact forms
CREATE POLICY "Allow anonymous contact form submissions"
  ON contact_submissions
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- Ensure the table has RLS enabled (should already be enabled based on schema)
ALTER TABLE contact_submissions ENABLE ROW LEVEL SECURITY;