CREATE TABLE IF NOT EXISTS customer_inquiry (
    id SERIAL PRIMARY KEY,
    category VARCHAR(50),
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    username VARCHAR(100),
    status VARCHAR(20) NOT NULL DEFAULT 'WAITING',
    answer TEXT,
    responder VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    answered_at TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_customer_inquiry_created_at
    ON customer_inquiry (created_at DESC);
