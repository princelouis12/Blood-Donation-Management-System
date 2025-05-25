-- Add loyalty points and last donation date
ALTER TABLE DONOR_PROFILE ADD (
    loyalty_points NUMBER DEFAULT 0,
    last_donation_date DATE
);

-- Create index on blood type
CREATE INDEX idx_blood_type ON DONOR_PROFILE(blood_type);

-- Create view for active and eligible donors
CREATE VIEW ACTIVE_ELIGIBLE_DONORS AS
SELECT 
    d.donor_id, 
    d.first_name, 
    d.last_name, 
    d.blood_type, 
    d.phone_number
FROM DONOR_PROFILE d
JOIN MEDICAL_HISTORY m ON d.donor_id = m.donor_id
WHERE d.status = 'ACTIVE'
  AND m.eligibility_status = 'ELIGIBLE'
  AND (m.next_eligible_date IS NULL OR m.next_eligible_date <= SYSDATE);
