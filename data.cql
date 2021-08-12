

-- Keyspace
CREATE KEYSPACE IF NOT EXISTS retrospect WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };


-- Back-end
CREATE TABLE IF NOT EXISTS retrospect.spans (
span_id         text,
trace_id        text,
session_id      text,
user_id         text,
chapter_id      text,

time_sent       bigint,
trigger_route   text,
status_code     smallint,
data            ascii,
request_data    ascii,
time_duration   duration,

PRIMARY KEY(span_id, session_id, time_sent)
) WITH CLUSTERING ORDER BY (session_id DESC, time_sent DESC);

CREATE INDEX ON retrospect.spans (trace_id);
CREATE INDEX ON retrospect.spans (session_id);
CREATE INDEX ON retrospect.spans (user_id);
CREATE INDEX ON retrospect.spans (chapter_id);
CREATE INDEX ON retrospect.spans (time_sent);
CREATE INDEX ON retrospect.spans (request_data);


-- Front-end
CREATE TABLE IF NOT EXISTS retrospect.events (
session_id      text,
user_id         text,
chapter_id      text,
data            ascii,

PRIMARY KEY(data, session_id)
);
CREATE INDEX ON retrospect.events (session_id);
CREATE INDEX ON retrospect.events (user_id);
CREATE INDEX ON retrospect.events (chapter_id);


-- Full dom snapshots
CREATE TABLE IF NOT EXISTS retrospect.snapshots (
session_id      text,
data            ascii,

PRIMARY KEY(data, session_id)
);
CREATE INDEX ON retrospect.snapshots (session_id);


-- DB Span Queue
CREATE TABLE IF NOT EXISTS retrospect.db_span_buffer (
  span_id         text,
  trace_id        text,

  chapter_id      text,
  session_id      text,
  user_id         text,
  trigger_route   text,

  time_sent       bigint,
  status_code     smallint,
  data            ascii,
  request_data    ascii,
  time_duration   duration,

  PRIMARY KEY(span_id)
);
CREATE INDEX ON retrospect.db_span_buffer (session_id);
CREATE INDEX ON retrospect.db_span_buffer (trace_id);