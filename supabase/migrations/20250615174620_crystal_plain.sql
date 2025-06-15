/*
  # Fix RLS policy for contact submissions

  1. Policy Updates
    - Drop the problematic "Users can read own contact submissions" policy
    - The existing policies should be sufficient:
      - "Allow public contact form submissions" for INSERT by anon users
      - "Authenticated users can view all submissions" for SELECT by authenticated users

  2. Security
    - Anonymous users can insert contact form submissions (public contact form)
    - Only authenticated users can read submissions
    - No changes to existing INSERT policy for anon users
*/

-- Drop the problematic policy that's causing the RLS violation
DROP POLICY IF EXISTS "Users can read own contact submissions" ON contact_submissions;

-- The remaining policies are sufficient:
-- 1. "Allow public contact form submissions" - allows anon INSERT
-- 2. "Authenticated users can view all submissions" - allows authenticated SELECT