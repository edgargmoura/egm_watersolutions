/*
  # Fix contact submissions RLS policy

  1. Security Updates
    - Drop existing INSERT policy that may have incorrect configuration
    - Create new INSERT policy for anonymous users with proper conditions
    - Ensure anonymous users can submit contact forms without authentication

  2. Policy Details
    - Allow INSERT operations for 'anon' role (unauthenticated users)
    - No restrictions on the data being inserted
    - Maintains existing SELECT policy for authenticated users
*/

-- Drop the existing INSERT policy if it exists
DROP POLICY IF EXISTS "Allow anonymous contact form submissions" ON contact_submissions;

-- Create a new INSERT policy for anonymous users
CREATE POLICY "Allow anonymous contact form submissions"
  ON contact_submissions
  FOR INSERT
  TO anon
  WITH CHECK (true);