/*
  # Fix contact form RLS policy

  1. Security Updates
    - Drop existing INSERT policy that may be misconfigured
    - Create new INSERT policy for anonymous users to submit contact forms
    - Ensure the policy allows all anonymous insertions with proper conditions

  This migration fixes the RLS policy violation error when submitting contact forms.
*/

-- Drop the existing INSERT policy if it exists
DROP POLICY IF EXISTS "Allow public contact form submissions" ON contact_submissions;

-- Create a new INSERT policy that allows anonymous users to submit contact forms
CREATE POLICY "Enable contact form submissions for anonymous users"
  ON contact_submissions
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- Ensure RLS is enabled (should already be enabled based on schema)
ALTER TABLE contact_submissions ENABLE ROW LEVEL SECURITY;